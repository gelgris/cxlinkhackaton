package main

import (
	"cl-ir-hackathon-empathy-audio/audiolambda"
	"github.com/aws/aws-lambda-go/lambda"
)

// Runs on S3 event when app puts an audio file to input bucket and creates a Transcribe job
func main() {
	lambda.Start(audiolambda.AudioHandler)
}
