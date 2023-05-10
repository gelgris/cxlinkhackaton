package filterlambda

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"strings"

	"github.com/aws/aws-sdk-go/service/s3"
)

func extractInterview(pFile *s3.GetObjectOutput) (Interview, error) {
	var vCompressed []byte
	var vUncompressed []byte
	var vComprehendOutput ComprehendOutput
	var vInterview Interview
	var vDNIScore float32
	var vErr error

	// if _, vErr = pFile.Body.Read(vCompressed); vErr != nil {
	if vCompressed, vErr = ioutil.ReadAll(pFile.Body); vErr != nil {
		log.Println("Error reading object content from s3:", vErr.Error())
		return vInterview, vErr
	}

	if vUncompressed, vErr = uncompressTargz(vCompressed); vErr != nil {
		log.Println("Error uncompressing tar.gz file")
		return vInterview, vErr
	}

	// Unmarshall to Comprehend Output structure
	if vErr = json.Unmarshal(vUncompressed, &vComprehendOutput); vErr != nil {
		return vInterview, vErr
	}

	// Extract interview Id. File name is like <Interview_ID>-<chunk_nr>
	vInterview.Id = strings.Split(vComprehendOutput.File, "-")[0]

	// Read all entities from json
	for _, entity := range vComprehendOutput.Entities {
		switch entity.Type {
		case DNI:
			// If a better determined DNI entity is found
			if vDNIScore < entity.Score {
				vDNIScore = entity.Score
				if vInterview.DocId, vErr = processDNITranscription(entity.Text); vErr != nil {
					return vInterview, vErr
				}
			}
		case PERSON:
			vInterview.Name = entity.Text
		case LOCATION:
			vInterview.City = entity.Text
		}
	}

	return vInterview, nil
}
