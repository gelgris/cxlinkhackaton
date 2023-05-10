package audiolambda

import (
	"context"
	"fmt"
	"log"
	"path/filepath"
	"strings"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	transcribe "github.com/aws/aws-sdk-go/service/transcribeservice"
)

func AudioHandler(ctx context.Context, event events.S3Event) error {
	var vSess *session.Session
	var vBucket string
	var vMediaURI string
	var vKey string
	vJobName := new(string)
	var vJobParams *transcribe.StartTranscriptionJobInput
	var vErr error

	if vSess, vErr = session.NewSession(); vErr != nil {
		log.Println("Error creating session:", vErr)
		return vErr
	}

	// Create a Transcribe client
	vTranscribeClient := transcribe.New(vSess)

	vRecord := event.Records[0]
	vBucket = vRecord.S3.Bucket.Name
	vKey = vRecord.S3.Object.Key

	// Name transcribe job as input file
	*vJobName = strings.Split(filepath.Base(vKey), ".")[0]
	// Create an S3 URI for the input media file
	vMediaURI = fmt.Sprintf("s3://%s/%s", vBucket, vKey)
	// Set interviewr ID
	vInterviewID := strings.Split(*vJobName, "-")[0]

	// Set up the Transcribe job parameters
	vJobParams = &transcribe.StartTranscriptionJobInput{
		TranscriptionJobName: vJobName,
		Media: &transcribe.Media{
			MediaFileUri: &vMediaURI,
		},
		OutputBucketName: aws.String(OUTPUT_BUCKET),
		OutputKey:        aws.String(OUTPUT_KEY + "/" + vInterviewID + "/"),
		LanguageCode:     aws.String(LANGUAGE), // Set the desired language code
	}

	// Start the Transcribe job
	if _, vErr = vTranscribeClient.StartTranscriptionJobWithContext(ctx, vJobParams); vErr != nil {
		log.Println("Failed to start Transcribe job:", vErr)
		return vErr
	}

	log.Println("Created Transcribe job:", vJobName)

	return nil
}
