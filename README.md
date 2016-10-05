strawpay/certbot
======================

Docker container with certbot and  cron support. The certbot comand comes from docker image [quay.io/letsencrypt/letsencrypt](https://quay.io/letsencrypt/letsencrypt). See [certbot](https://certbot.eff.org/) for information about certbot.

There are two modes of operations single and schduled:

    docker run ... strawpay/docker-certbot <certbot options>
    docker run ... strawpay/docker-certbot scheduled <certbot options>

## Single mode
The container will run once, performing the specfied certbot operation and exit.
<certbot options> is passed verbatim to the certbot command.

## Scheduled mode
Schedules the certbot command. <certbot options> is passed verbatim to the certbot command.
The container sets up a cron job and continues running, outputting the result of the ran jobs.
The schedule defaults to "11 3 * * *"
Set the environment variable CRON_SCHEDULE to specify your own schedule.

### Examples:

Run once, setting up www.example.com

    docker run --rm -t strawpay/docker-certbot certonly --standalone -d example.com -d www.example.com

Run once, checking what renew would do

    docker run --rm -t strawpay/docker-certbot renew --dry-run

Renew at 03:11 every day

    docker run -d strawpay/docker-certbot scheduled renew -q

Renew at 5:15 every day 

    docker run -d 
    	-e CRON_SCHEDULE='15 5 * * *' \
    	strawpay/docker-certbot scheduled renew 

