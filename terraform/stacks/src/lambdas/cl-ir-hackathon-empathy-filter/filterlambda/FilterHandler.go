package filterlambda

import (
	"context"
	"log"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3"
)

func FilterHandler(ctx context.Context, s3Event events.S3Event) error {
	var vSess *session.Session
	var vErr error
	var vFile *s3.GetObjectOutput
	var vInterview Interview

	if vSess, vErr = session.NewSession(); vErr != nil {
		log.Println("Error creating session:", vErr)
		return vErr
	}

	// Create an S3 client
	vS3Client := s3.New(vSess)

	vBucket := s3Event.Records[0].S3.Bucket.Name
	vKey := s3Event.Records[0].S3.Object.Key

	if vFile, vErr = vS3Client.GetObject(&s3.GetObjectInput{
		Bucket: aws.String(vBucket),
		Key:    aws.String(vKey),
	}); vErr != nil {
		// log.Fatal(vErr)
		log.Printf("error getting s3 object %s/%s: %s", vBucket, vKey, vErr)
		return vErr
	}

	log.Println("S3 GetObject executed successfully. Start to extract Person structure")

	if vInterview, vErr = extractInterview(vFile); vErr != nil {
		log.Printf("error processing comprehend file %s/%s: %s", vBucket, vKey, vErr)
		return vErr
	}

	// defer vFile.Body.Close()

	// Write into dynamodb
	if vErr = insertUpdateDynamoDB(vSess, vInterview); vErr != nil {
		log.Printf("error inserting/updating dynamodb: %s", vErr)
	}

	return nil
}
