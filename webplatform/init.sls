{%- set level = salt['grains.get']('level', 'production') -%}
{%- set users = salt['pillar.get']('users', {}) -%}
{%- set salt_master_ip = salt['pillar.get']('infra:salt:master:private') -%}

include:
  - users

/srv/webplatform:
  file:
    - directory
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

{% for username in users %}
/home/{{ username }}/.screenrc:
  file.managed:
    - mode: 640
    - source: salt://webplatform/files/screenrc.jinja
    - template: jinja
    - user: {{ username }}
    - group: {{ username }}
    - require:
      - user: {{ username }}
    - context:
        level: {{ level }}
{%- endfor %}

/etc/resolvconf/resolv.conf.d/base:
  file.managed:
    - contents: |
        search {{ level }}.wpdn
        domain {{ level }}.wpdn
        nameserver 8.8.8.8

/etc/resolvconf/resolv.conf.d/head:
  file.managed:
    - contents: |
        # Managed by Salt Stack
        # Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)
        #     DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN
        #     salt.wpdn   # #TODO hardcoded salt-master in gdnsd zone files
        nameserver {{ salt_master_ip }}
    - require_in:
      - cmd: resolvconf -u

non-needed-softwares:
  pkg.removed:
    - pkgs:
      - landscape-common
      - landscape-client

commonly-used-utilities:
  pkg.installed:
    - names:
      - screen
      - htop

/usr/bin/timeout:
  file.exists

resolvconf -u:
  cmd.run:
    - unless: grep -q -e 'wpdn' /etc/resolv.conf

/etc/profile.d/wpd_aliases.sh:
  file.managed:
    - source: salt://webplatform/files/wpd_aliases.sh
    - mode: 755

/etc/apt/sources.list.d/wikimedia.list:
  file.managed:
    - contents: |
        # Managed by Salt Stack at salt/webplatform/init.sls
        deb http://ubuntu.wikimedia.org/ubuntu trusty main
        deb http://ubuntu.wikimedia.org/ubuntu trusty-updates main
        deb http://ubuntu.wikimedia.org/ubuntu trusty-security main

#/etc/sysctl.conf:
#  file.append:
#    - text: |
#        #
#        ###################################################################
#        # WebPlatform Docs; Attempt fixing memory allocation issue
#        # Attempt on fixing "X invoked oom-killer: gfp_mask=, order=0, oom_adj=0"
#        # http://askubuntu.com/questions/161521/why-does-my-server-freeze-everyday-at-the-same-time
#        # http://www.hskupin.info/2010/06/17/how-to-fix-the-oom-killer-crashe-under-linux/
#        # https://www.kernel.org/doc/Documentation/vm/overcommit-accounting
#        vm.overcommit_memory = 2
#        vm.overcommit_ratio = 80


/usr/local/bin/wpd-autoupdate.sh:
  file.managed:
    - source: salt://webplatform/files/wpd-autoupdate.sh
    - mode: 755
##
##TODO Loop through web apps
##
#{% set appNameUpdateId = 'tmp' %}
#{% set appCodePath = 'tmp' %}
#{{ appNameUpdateId }}-crontab:
#  cron.present:
#    - identifier: {{ appNameUpdateId }} 
#    - user: root
#    - hour: '*/2'
#    - name: "JOBNAME={{ appNameUpdateId }} CODE_PATH={{ appCodePath }} cronhelper.sh /usr/local/bin/wpd-autoupdate.sh"
#    - require:
#      - file: /usr/local/bin/wpd-autoupdate.sh
