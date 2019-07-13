if [ ! -n "$WERCKER_NEWRELIC_DEPLOYMENT_API_KEY" ]; then
  error 'Please specify api_key property'
  exit 1
fi

if [ ! -n "$WERCKER_NEWRELIC_DEPLOYMENT_APP_ID" ]; then
  error 'Please specify app_id property'
  exit 1
fi

if [ ! -n "$WERCKER_NEWRELIC_DEPLOYMENT_REVISION" ]; then
  export WERCKER_NEWRELIC_DEPLOYMENT_REVISION="${WERCKER_GIT_BRANCH}/${WERCKER_GIT_COMMIT}"
fi

if [ ! -n "$WERCKER_NEWRELIC_DEPLOYMENT_ON" ]; then
  WERCKER_NEWRELIC_DEPLOYMENT_ON="passed"
fi

if [ "$WERCKER_NEWRELIC_DEPLOYMENT_ON" = "passed" ]; then
  if [ "$WERCKER_RESULT" = "failed" ]; then
    echo "Skipping..."
    return 0
  fi
fi

# See https://docs.newrelic.com/docs/apm/new-relic-apm/maintenance/recording-deployments
curl -X POST 'https://api.newrelic.com/v2/applications/${WERCKER_NEWRELIC_DEPLOYMENT_APP_ID}/deployments.json' \
     -H 'X-Api-Key:${WERCKER_NEWRELIC_DEPLOYMENT_API_KEY}' -i \
     -H 'Content-Type: application/json' \
     -d \
'{
  "deployment": {
    "revision": "${WERCKER_NEWRELIC_DEPLOYMENT_REVISION}",
    "user": "${WERCKER_STARTED_BY}"
  }
}' 

