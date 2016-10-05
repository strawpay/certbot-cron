FROM quay.io/letsencrypt/letsencrypt
MAINTAINER Strawpay <info@strawpay.com>

RUN apt-get update && \
    apt-get install -y cron && \
    rm -rf /var/lib/apt/lists/*

ADD start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
CMD [""]
