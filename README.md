newrelic-deployment
===================

Send a deploy event to NewRelic


Example
--------

Add NEWRELIC_API_KEY as deploy target or application environment variable.

```
    - hashfyre/newrelic-deployment:
        api_key: $NEWRELIC_API_KEY
        app_name: MyApp
        skip: **OPTIONAL** // default: 'true'
        revision: **OPTIONAL** // default: '$WERCKER_GIT_BRANCH/$WERCKER_GIT_COMMIT by $WERCKER_STARTED_BY'
```

Set `skip` to `true` to skip the step optionally for pipelines. Default is `false`.
