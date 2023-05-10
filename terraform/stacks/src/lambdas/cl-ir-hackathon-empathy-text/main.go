package main

import (
	"cl-ir-hackathon-empathy-text/textlambda"
	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	lambda.Start(textlambda.TextHandler)
}
