#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Enter Focus Mode
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎧
# @raycast.argument1 { "type": "text", "placeholder": "until" }

# Documentation:
# @raycast.author ajclarkson
# @raycast.authorURL https://raycast.com/ajclarkson

source .env

STATUS_TEXT="Deep Work - Replies may be slow"
STATUS_EMOJI=":headphones:"
STATUS_EXPIRATION=$(gdate -d "today $1" +%s)

CURRENT_TIME=$(gdate +%s)
MINS_UNTIL_EXPIRATION=$(( ($STATUS_EXPIRATION - $CURRENT_TIME) / 60 ))

# Main program
if [[ -z "$SLACK_OAUTH_TOKEN" ]]
then 
  echo "No SLACK_OAUTH_TOKEN provided, this is usually in a local .env file"
  exit 1
fi

if [[ -z "$1" ]]
then
  echo "You must provide an \"until\" time"
  exit 1
fi

RESPONSE=$(
curl \
  --header "Authorization: Bearer $SLACK_OAUTH_TOKEN" \
  --request POST \
  --show-error \
  --fail \
  --silent \
  "https://slack.com/api/dnd.setSnooze?num_minutes=$MINS_UNTIL_EXPIRATION"
) 
if [[ "$RESPONSE" =~ "error" ]]
then
  echo "Failed to pause notifications in Slack"
  exit 1
fi

RESPONSE=$(
curl \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer $SLACK_OAUTH_TOKEN" \
  --request POST \
  --data "{ 'profile': { 'status_text': '$STATUS_TEXT', 'status_emoji': '$STATUS_EMOJI', 'status_expiration': $STATUS_EXPIRATION } }" \
  --silent \
  --show-error \
  --fail \
  "https://slack.com/api/users.profile.set"
) 

if [[ "$RESPONSE" =~ "error" ]]
then
  echo "Failed to set status in Slack"
  exit 1
else 
  echo "Focus Mode until " $(gdate -d "today $1" +%H:%M)
  exit 0
fi

