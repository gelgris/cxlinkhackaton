package filterlambda

import (
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/dynamodb"
	"github.com/aws/aws-sdk-go/service/dynamodb/dynamodbattribute"
)

func insertUpdateDynamoDB(pSession *session.Session, pInterview Interview) error {
	// Create a DynamoDB client
	vDynamoDBClient := dynamodb.New(pSession)

	// Convert pInterview object to AttributeValue map
	vItem, err := dynamodbattribute.MarshalMap(pInterview)
	if err != nil {
		return err
	}

	// Create the DynamoDB PutItem input
	vInput := &dynamodb.PutItemInput{
		TableName: aws.String(DYNAMODB_TABLE_INTERVIEWS),
		Item:      vItem,
	}

	// Put the item into DynamoDB
	_, err = vDynamoDBClient.PutItem(vInput)
	if err != nil {
		return err
	}

	return nil
}
