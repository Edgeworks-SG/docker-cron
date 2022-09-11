# docker-cron

Example setup for running cron jobs inside docker.

## Usage

Build and run

```bash
docker build -t cron .
docker run --rm -it cron
```

The above will load `crontab.Development` and run [jobs/hello.sh](jobs/hello.sh) every minute.

## Production

1. Create your production script in `jobs` folder.

   Example `prod.sh`:

   ```bash
   #!/bin/bash

   echo 'hello world (from a job in production)'
   ```

2. Create `crontab.Production`

   ```crontab
   * * * * * /usr/scheduler/jobs/prod.sh
   ```

3. Build the image

   ```bash
   docker build -t cron .
   ```

4. Run image with `SCHEDULER_ENVIRONMENT` defined.

   ```bash
   docker run --rm -e SCHEDULER_ENVIRONMENT='Production' -it cron
   ```
