package main

import (
	"cl-ir-hackathon-empathy-filter/filterlambda"
	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	lambda.Start(filterlambda.FilterHandler)
}
