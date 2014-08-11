if [ ! -n "$WERCKER_NEWRELIC_DEPLOYMENT_API_KEY" ]; then
  error 'Please specify api_key property'
  exit 1
fi

if [ ! -n "$WERCKER_NEWRELIC_DEPLOYMENT_APP_NAME" ]; then
  error 'Please specify app_name property'
  exit 1
fi

if [ ! -n "$WERCKER_NEWRELIC_DEPLOYMENT_REVISION" ]; then
  export WERCKER_NEWRELIC_DEPLOYMENT_REVISION="$WERCKER_GIT_BRANCH/${WERCKER_GIT_COMMIT:0:10} by $WERCKER_STARTED_BY"
fi

NEWRELIC_API="https://api.newrelic.com"
NR_API_DEPLOYMENTS="$NEWRELIC_API/deployments.xml"

curl -H "x-api-key:${WERCKER_NEWRELIC_DEPLOYMENT_API_KEY}" -d "deployment[app_name]=${WERCKER_NEWRELIC_DEPLOYMENT_APP_NAME}" -d "deployment[revision]=${WERCKER_NEWRELIC_DEPLOYMENT_REVISION}" $NR_API_DEPLOYMENTS

