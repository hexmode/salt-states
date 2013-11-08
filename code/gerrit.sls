include:
  - rsync.secret
  - code.prereq

rsync -a --exclude '.git' --exclude '.svn' --delete --no-perms --password-file=/etc/codesync.secret codesync@deployment.webplatform.org::code/gerrit/ /srv/webplatform/gerrit/:
  cmd.wait:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform
