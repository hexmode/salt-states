python-swiftclient-install:
  pkg.installed:
    - pkgs:
      - python-pip
      - python-keystoneclient
  pip.installed:
    - name: python-swiftclient
    - require:
      - pkg: python-swiftclient-install 

/etc/profile.d/swift-dreamobjects.sh:
  file.managed:
    - mode: 755
    - template: jinja
    - source: salt://webplatform/files/swift-dreamobjects.sh.jinja
    - require:
      - pip: python-swiftclient
    - context:
        username: {{ salt['pillar.get']('accounts:swift:dreamhost:username') }}
        password: {{ salt['pillar.get']('accounts:swift:dreamhost:password') }}

{% if grains['nodename'] == 'salt' %}
/srv/ci-dreamobjects.sh:
  file.managed:
    - mode: 755
    - template: jinja
    - source: salt://webplatform/files/swift-dreamobjects.sh.jinja
    - require:
      - pip: python-swiftclient
    - context:
        username: {{ salt['pillar.get']('accounts:swift:ci:username') }}
        password: {{ salt['pillar.get']('accounts:swift:ci:password') }}
{%- endif -%}
