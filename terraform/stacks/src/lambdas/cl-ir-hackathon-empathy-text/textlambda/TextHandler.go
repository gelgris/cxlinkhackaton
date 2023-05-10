package textlambda

import (
	"bytes"
	"context"
	"encoding/json"
	"io/ioutil"
	"log"
	"path/filepath"
	"strings"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3"
)

func TextHandler(ctx context.Context, event events.S3Event) error {
	var vSess *session.Session
	var vS3Client *s3.S3
	var vFile *s3.GetObjectOutput
	var vFileContent []byte
	var vTranscribeOutput TranscribeOutput
	var vBucket string
	var vKey string
	var vOutputTextFile string
	var vErr error

	if vSess, vErr = session.NewSession(); vErr != nil {
		log.Println("Error creating session:", vErr)
		return vErr
	}

	vS3Client = s3.New(vSess)

	vRecord := event.Records[0]
	vBucket = vRecord.S3.Bucket.Name
	vKey = vRecord.S3.Object.Key

	if vFile, vErr = vS3Client.GetObject(&s3.GetObjectInput{
		Bucket: aws.String(vBucket),
		Key:    aws.String(vKey),
	}); vErr != nil {
		// log.Fatal(vErr)
		log.Printf("error getting s3 object %s/%s: %s", vBucket, vKey, vErr)
		return vErr
	}

	// if _, vErr = pFile.Body.Read(vCompressed); vErr != nil {
	if vFileContent, vErr = ioutil.ReadAll(vFile.Body); vErr != nil {
		log.Println("Error reading object content from s3:", vErr.Error())
		return vErr
	}

	if vErr = json.Unmarshal(vFileContent, &vTranscribeOutput); vErr != nil {
		log.Println("Error decoding Transcribe output json:", vErr.Error())
		return vErr
	}

	// Read transcription texts and concatenate all if multiple into vOutputTextFile as string
	for _, transcript := range vTranscribeOutput.Results.Transcripts {
		vOutputTextFile = vOutputTextFile + transcript.Transcript
	}

	// Write S3 object
	vInterviewId := strings.Split(filepath.Base(vKey), "-")[0]
	vPutObjectInput := &s3.PutObjectInput{
		Bucket:      aws.String(OUTPUT_BUCKET),
		Key:         aws.String(OUTPUT_KEY + "/" + vInterviewId + "/" + strings.Split(filepath.Base(vKey), ".")[0] + ".txt"), // File is the same as the input json but with txt extension
		ContentType: aws.String("text/plain"),
		Body:        bytes.NewReader([]byte(vOutputTextFile)),
	}

	if _, vErr = vS3Client.PutObject(vPutObjectInput); vErr != nil {
		log.Println("Put object error:", vErr.Error())
		return vErr
	}

	log.Println("Put S3 object executed successfully:", "s3://"+OUTPUT_BUCKET+OUTPUT_KEY+"/"+filepath.Base(vKey))

	return nil
}
