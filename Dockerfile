FROM alpine:3.16

# Install required packages
RUN apk add --update --no-cache bash dos2unix

# Install python/pip
RUN apk add --update --no-cache python3 && \
    ln -sf python3 /usr/bin/python
RUN python -m ensurepip --upgrade && \
    ln -sf pip3 /usr/bin/pip
RUN python -m pip install --upgrade pip
ENV PYTHONUNBUFFERED=1
RUN pip install wheel

# install any Python requirements used by the jobs
COPY install.sh .
RUN ./install.sh


WORKDIR /usr/scheduler

# Copy files
COPY crontab.* ./
COPY jobs/*.* ./jobs/
COPY start.sh .

# Fix line endings && execute permissions
RUN dos2unix crontab.* *.sh jobs/*.* \
    && \
    find . -type f -iname "*.sh" -exec chmod +x {} \;

# Run cron on container startup
CMD ["./start.sh"]