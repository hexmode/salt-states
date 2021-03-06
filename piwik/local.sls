{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set upstream_port = salt['pillar.get']('upstream:piwik:port', 8004) %}

include:
  - nginx.local
  - piwik

#
# This is the LOCAL virtual host state manager, this state is responsible to
# expose a basic HTTP server so that the frontend servers can proxy through it.
#

/etc/nginx/sites-available/local.stats:
  file.managed:
    - source: salt://piwik/files/nginx.local.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        upstream_port: {{ upstream_port }}
        fcgi_port: 9000
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/local.stats:
  file.symlink:
    - target: /etc/nginx/sites-available/local.stats
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/local.stats

