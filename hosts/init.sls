/etc/hosts:
  file.managed:
    - source: salt://hosts/files/hosts.jinja
    - template: jinja
    - mode: 444

append-to-hosts:
  file.append:
    - name: /etc/hosts
    - text: |
        {{ salt['pillar.get']('infra:db:master:private') }}	{{ salt['pillar.get']('infra:db:master:hostname') }}
