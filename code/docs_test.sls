# Include the common settings for the docs repo
include:
  - code.docs_settings
  - code.prereq
  - rsync.secret

## Normal mode - test deploys from same location as current
rsync -a --delete --no-perms --password-file=/etc/codesync.secret --exclude="LocalSettings.php" codesync@deployment.webplatform.org::code/docs/current/ /srv/webplatform/wiki/test/:
  cmd.run:
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform

## Upgrade mode - test runs from its own directory
#rsync -a --delete --no-perms --password-file=/etc/codesync.secret --exclude="LocalSettings.php" codesync@deployment.webplatform.org::code/docs/test/ /srv/webplatform/wiki/test/:
#  cmd.run:
#    - user: root
#    - group: root
#    - require:
#      - file: /etc/codesync.secret
#      - file: /srv/webplatform