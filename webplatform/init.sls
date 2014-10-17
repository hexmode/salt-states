/srv/webplatform:
  file:
    - directory
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

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
      - sysstat

/usr/bin/timeout:
  file.exists

sysstat:
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: sysstat
    - watch:
      - file: /etc/default/sysstat

/etc/default/sysstat:
  file.managed:
    - source: salt://webplatform/files/default-sysstat.jinja
    - template: jinja
    - require:
      - pkg: sysstat

resolvconf -u:
  cmd.run

/etc/resolvconf/resolv.conf.d/base:
  file.managed:
    - contents: |
        search staging.wpdn
        domain staging.wpdn
        nameserver 8.8.8.8

/etc/apt/sources.list.d/wikimedia.list:
  file.managed:
    - contents: |
        # Managed by Salt Stack at salt/webplatform/init.sls
        deb http://ubuntu.wikimedia.org/ubuntu trusty main
        deb http://ubuntu.wikimedia.org/ubuntu trusty-updates main
        deb http://ubuntu.wikimedia.org/ubuntu trusty-security main

/etc/resolvconf/resolv.conf.d/head:
  file.managed:
    - contents: |
        # Managed by Salt Stack
        # Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)
        #     DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN
        #     salt.wpdn   # Hardcoded salt-master as dns.server #TODO
        nameserver 10.10.10.76
    - require_in:
      - cmd: resolvconf -u

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
#
##
## TODO, use webat25 autoupdate and make generic
##
#/usr/local/bin/wpd-autoupdate.sh:
#  file.managed:
#    - source: salt://code/files/web25/webat25-autoupdate.sh
#    - name: /srv/code/web25ee/web25-autoupdate.sh
#    - mode: 755
