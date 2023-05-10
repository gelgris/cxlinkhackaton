package main

import (
	"cl-ir-hackathon-empathy-consolidation/consolidationlambda"
	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	lambda.Start(consolidationlambda.ConsolidationHandler)
}
