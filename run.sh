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

NR_API_VAR="x-api-key"
NR_DEPLOY_APP="deployment[app_name]"
NR_DEPLOY_REV="deployment[revision]"
NR_DEPLOY_SKIP="deployment[skip]"

if [ "$WERCKER_NEWRELIC_DEPLOYMENT_SKIP" == "false" ]; then
  curl \
    -H "$NR_API_VAR:${WERCKER_NEWRELIC_DEPLOYMENT_API_KEY}" \
    -d "$NR_DEPLOY_APP=${WERCKER_NEWRELIC_DEPLOYMENT_APP_NAME}" \
    -d "$NR_DEPLOY_REV=${WERCKER_NEWRELIC_DEPLOYMENT_REVISION}" \
    $NR_API_DEPLOYMENTS
fi
