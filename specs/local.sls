{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set level = salt['grains.get']('level', 'production') -%}
{%- set upstream_port = salt['pillar.get']('upstream:specs:port', 8003) %}

include:
  - nginx.local
  - .

#
# This is the LOCAL virtual host state manager, this state is responsible to
# expose a basic HTTP server so that the frontend servers can proxy through it.
#

/etc/nginx/sites-available/local.specs:
  file.managed:
    - source: salt://specs/files/nginx.local.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        level: {{ level }}
        upstream_port: {{ upstream_port }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/local.specs:
  file.symlink:
    - target: /etc/nginx/sites-available/local.specs
    - watch_in:
      - service: nginx
    - require:
      - file: /etc/nginx/sites-available/local.specs

