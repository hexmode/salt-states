cron:
  pkg:
    - installed
  service.running:
    - enable: True
    - require:
      - pkg: cron
      - file: /etc/profile.d/mailto.sh

/etc/profile.d/mailto.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://cron/mailto.sh

/usr/bin/cronhelper.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://cron/cronhelper.sh
    - require:
      - service: cron

/usr/local/sbin/archive-noncommited.sh:
  file.managed:
    - mode: 755
    - source: salt://cron/archive-noncommited.sh
    - require:
      - service: cron

{% for job, args in pillar.get('cron', {}).items() %}
{{ job }}:
  cron.present:
    - user: {{ args.get('user', 'root') }}
    - minute: {{ args.get('minute', '\*') }}
    - hour: {{ args.get('hour', '\*') }}
    {% if 'daymonth' in args %}
    - daymonth: {{ args.get('daymonth') }}
    {% endif %}
    {% if 'month' in args %}
    - month: {{ args.get('month') }}
    {% endif %}
    {% if 'dayweek' in args %}
    - dayweek: {{ args.get('dayweek') }}
    {% endif %}
{% endfor %}
