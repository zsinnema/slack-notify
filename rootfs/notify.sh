#!/bin/bash

set -e

# The Slack-assigned webhook
export SLACK_WEBHOOK=https://hooks.slack.com/services/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
# A URL to an icon
export SLACK_ICON=https://accounts.ifnneurologic.com/auth/resources/h3yz9/login/custom/img/favicon.ico
# The title of the message
export SLACK_TITLE="Today's IFN stats"
# The name of the sender of the message. Does not need to be a "real" username
export SLACK_USERNAME="Zoran"

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
export SLACK_MESSAGE=`echo -e Total number of patients: ${num_patients}\\nTotal number of consultations: ${num_consultations}`

/slack-notify
