#!/bin/bash

set -e

# The Slack-assigned webhook
export SLACK_WEBHOOK=https://hooks.slack.com/services/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
# The title of the message
export SLACK_TITLE="Today's IFN stats"
# The name of the sender of the message. Does not need to be a "real" username
export SLACK_CHANNEL="ifn"

export num_patients=`mongo mongodb://stats:stats@mnp-ifn-db:27017/mnp-ifn-db --quiet <<_eof
db.patient.count()
exit
_eof
`

export num_consultations=`
mongo mongodb://stats:stats@mnp-ifn-db:27017/mnp-ifn-db --quiet <<_eof
db.consultation.count()
exit
_eof
`

# The body of the message
export SLACK_MESSAGE="${SLACK_TITLE}\n\nTotal number of patients: *${num_patients}*\nTotal number of consultations: *${num_consultations}*"

curl -H "Content-type: application/json" \
--data "{\"blocks\":[{\"type\":\"section\",\"text\":{\"type\":\"mrkdwn\",\"text\":\"${SLACK_MESSAGE}\"}}]}" \
-X POST ${SLACK_WEBHOOK}
