package extractlambda

import (
	"context"
	"log"
	"path/filepath"
	"strings"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/comprehend"
)

func ExtractHandler(ctx context.Context, event events.S3Event) error {
	var vSess *session.Session
	var vBucket string
	var vKey string
	vJobName := new(string)
	vAccessRole := new(string)
	var vInput *comprehend.StartEntitiesDetectionJobInput
	var vOutput *comprehend.StartEntitiesDetectionJobOutput
	var vErr error

	if vSess, vErr = session.NewSession(); vErr != nil {
		log.Println("Error creating session:", vErr)
		return vErr
	}

	vComprehendClient := comprehend.New(vSess)

	vRecord := event.Records[0]
	vBucket = vRecord.S3.Bucket.Name
	vKey = vRecord.S3.Object.Key
	// Name comprehend job as input file
	*vJobName = strings.Split(filepath.Base(vKey), ".")[0] + "_CUSTOM_DNI"
	*vAccessRole = INPUT_DATA_ACCESS_ROLE

	// Create Comprehend job with custom entities DNI
	vInput = &comprehend.StartEntitiesDetectionJobInput{
		InputDataConfig: &comprehend.InputDataConfig{
			S3Uri: aws.String("s3://" + vBucket + "/" + vKey),
		},
		OutputDataConfig: &comprehend.OutputDataConfig{
			S3Uri: aws.String("s3://" + OUTPUT_BUCKET + "/"),
		},
		DataAccessRoleArn:   aws.String(INPUT_DATA_ACCESS_ROLE),
		LanguageCode:        aws.String(LANGUAGE),
		EntityRecognizerArn: aws.String(CUSTOM_DNI),
		JobName:             vJobName,
		// ClientRequestToken:  aws.String("unique-token"), // Replace with a unique token for each job
		// VolumeKmsKeyId:      aws.String(""),             // Optional: specify a KMS key ID for encryption at rest
	}

	if _, vErr = vComprehendClient.StartEntitiesDetectionJob(vInput); vErr != nil {
		log.Println("Error creating Comprehend job:", vErr)
		return vErr
	}

	// Create another job for standard entities
	*vJobName = strings.Split(filepath.Base(vKey), ".")[0] + "_ENTITIES"
	vInput = &comprehend.StartEntitiesDetectionJobInput{
		InputDataConfig: &comprehend.InputDataConfig{
			S3Uri: aws.String("s3://" + vBucket + "/" + vKey),
		},
		OutputDataConfig: &comprehend.OutputDataConfig{
			S3Uri: aws.String("s3://" + OUTPUT_BUCKET + "/"),
		},
		DataAccessRoleArn: aws.String(INPUT_DATA_ACCESS_ROLE),
		LanguageCode:      aws.String(LANGUAGE),
		JobName:           vJobName,
		// ClientRequestToken:  aws.String("unique-token"), // Replace with a unique token for each job
		// VolumeKmsKeyId:      aws.String(""),             // Optional: specify a KMS key ID for encryption at rest
	}

	if _, vErr = vComprehendClient.StartEntitiesDetectionJob(vInput); vErr != nil {
		log.Println("Error creating Comprehend job:", vErr)
		return vErr
	}

	log.Println("Created Comprehend job:", *vOutput.JobId)

	return nil
}
