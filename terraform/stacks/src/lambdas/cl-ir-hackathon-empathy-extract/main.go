package main

import (
	"cl-ir-hackathon-empathy-extract/extractlambda"
	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	lambda.Start(extractlambda.ExtractHandler)
}
