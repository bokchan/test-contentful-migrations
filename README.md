Run docker-compose container

Testing `migrations init` with different configurations.

All executions have the same behavior:

    - exists with a 0, i.e. "success"
    - does _not_ write the management token to config
    - does _not_ create the migrationContenType remotely.

    migrations init [--config config-file]
    # prompts for management token
    ✔ Management Token · CFPAT-*****
    ✔ API Base URL · api.contentful.com

    docker-compose run -ti --rm migrations sh

    # run with environment variables loaded from the .env file
    migrations init

    # run with .migrationsrc config file
    migrations init --config .migrationsrc

    # run with .migrations.config.js config file
    migrations init --config .migrations.config.js

I checked manually in the Contentful webui that the contentType is not created.
And `migrations version --add` fails expectedly with the error:

```
> migrations version --add migrations/1750975843605-create-faqComponent-migration.js
 # prompts for management token
✔ Management Token · CFPAT-*******

Adding migration entry 1750975843605 ...

Error: {
  "status": 400,
  "statusText": "Bad Request",
  "message": "The content type you sent could not be found or was not activated.",
  "details": {},
  "request": {
    "url": "/spaces/bmbos5ssls9v/environments/master/entries/1750975843605",
    "headers": {
      "Accept": "application/json, text/plain, */*",
      "Content-Type": "application/vnd.contentful.management.v1+json",
      "X-Contentful-User-Agent": "sdk contentful-management.js/11.54.0; platform node.js/v20.19.3; os Linux/v20.19.3;",
      "Authorization": "Bearer ...a8Pyo",
      "X-Contentful-Content-Type": "contentfulMigrations",
      "User-Agent": "axios/1.9.0",
      "Content-Length": "179",
      "Accept-Encoding": "gzip, compress, deflate, br"
    },
    "method": "put",
    "payloadData": "{\"fields\":{\"version\":{\"en-US\":\"1750975843605\"},\"name\":{\"en-US\":\"1750975843605-create-faqComponent-migration.js\"},\"state\":{\"en-US\":\"success\"},\"message\":{\"en-US\":\"Manually added\"}}}"
  },
  "requestId": "a919549c-e38d-4caa-949a-423fd612bbea"
}
```
