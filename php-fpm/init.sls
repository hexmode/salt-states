{#
 # PHP FPM base configuration
 #
 # Notes:
 #   - To know the non-swapped memory usage php5-fpm consumes, run:
 #     (Note that the RSS column gives values in KiB)
 #
 #       ps -ylC php5-fpm --sort:rss
 #
 #     Total available RAM / ~ 80Mb per fpm process  = pm.max_children
 #
 # Ref:
 #   - https://rtcamp.com/tutorials/php/fpm-status-page/
 #   - https://rtcamp.com/tutorials/php/fpm-sysctl-tweaking/
 #   - http://myshell.co.uk/index.php/adjusting-child-processes-for-php-fpm-nginx/
 #}
include:
  - mmonit

php5-fpm:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: php5-fpm

/etc/php5/fpm/pool.d/www.conf:
  file.managed:
    - contents: |
        ; Managed by Salt Stack from state php-fpm/init.sls
        [www]
        listen = 127.0.0.1:9000
        user = www-data
        group = www-data
        chdir = /
        pm = dynamic
        pm.max_children = 25
        pm.start_servers = 10
        pm.min_spare_servers = 5
        pm.max_spare_servers = 10
        pm.max_requests = 500
        pm.status_path = /status
    - require:
      - pkg: php5-fpm
    - watch_in:
      - service: php5-fpm

/etc/monit/conf.d/php5-fpm.conf:
  file.managed:
    - source: salt://php-fpm/files/monit.conf.jinja
    - template: jinja
    - context:
        ip4_interfaces: {{ salt['grains.get']('ip4_interfaces:eth0') }}
        fpm_port: 9000
    - require:
      - service: php5-fpm
    - watch_in:
      - service: monit

