#!/bin/bash


#Before Add keys or make aws configure

aws sts get-caller-identity

creds=$(aws sts assume-role --role-arn "arn:aws:iam::242906888793:role/AWS_Sandbox" --role-session-name AWS_Sandbox --output text | grep CREDENTIALS)

#echo $creds

export AWS_ACCESS_KEY_ID=$(echo $creds | cut -d' ' -f2)
export AWS_SECRET_ACCESS_KEY=$(echo $creds | cut -d' ' -f4)
export AWS_SESSION_TOKEN=$(echo $creds | cut -d' ' -f5)


aws sts get-caller-identity
