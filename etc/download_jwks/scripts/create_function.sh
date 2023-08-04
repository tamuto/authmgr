#!/bin/bash
set -eu

python -m zipfile -c lambda.zip src/usermgr_dl_jwks.py

aws lambda create-function --function-name usermgr_dl_jwks \
--zip-file fileb://lambda.zip --handler usermgr_dl_jwks.handler --runtime python3.11 \
--environment "Variables={USERPOOL_ID=$USERPOOL_ID,REGION=$AWS_REGION}" \
--role arn:aws:iam::$ACCOUNT_ID:role/$ROLE | jq .

rm lambda.zip
