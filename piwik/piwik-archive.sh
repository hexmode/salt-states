#!/bin/bash -l
/usr/bin/logger -i -p local1.notice -t cron "[notice] Host `hostname` ran Piwik hourly archive"
/usr/bin/php /srv/webplatform/piwik/misc/cron/archive.php -- url=http://tracking.webplatform.org/ > /var/log/piwik-archive.log
