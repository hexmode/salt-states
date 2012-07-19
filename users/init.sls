laner:
  group.present:
    - gid: 1001
  user.present:
    - shell: /bin/bash
    - uid: 1001
    - gid: 1001
    - groups:
      - ops
      - deployment
    - require:
      - group: laner
      - group: ops
      - group: deployment

AAAAB3NzaC1yc2EAAAADAQABAAABAQD6lKom1wW/TQzxv2t8xOezDhR/imfMKge35SiHDnau/L+Dtl6HF2rArzs1cx3lMHJEmH6Weykxo8/fbtzXsF0lYa9iu97DcMCAYHNbmqnTjgZypNXV0AU/9JZzsBY3kSNL87byddb7Pz8JVXHmChoPfP1dc6v+nzGxsE7o/dVGI25zQo99Vtt1Io4dN8lBQs81NtYKPWYDZRX/H/rN8qaCdzLng6/JpIczQBV+Jzj74v1I3XgynAu2tGmQCwbN9J1fNGUp1Fe9x6/mw2lh0mPJSwMRYfp81SjLA0doxOMRzD1qxUraRvI0x+qZW+5wkqCe7z0AqcfHmZ1/wHMa2iLr:
  ssh_auth:
    - present
    - user: laner
    - enc: ssh-rsa
    - comment: laner@Free-Public-Wifi.local
    - require:
      - user: laner

shepazu:
  group.present:
    - gid: 1002
  user.present:
    - shell: /bin/bash
    - uid: 1002
    - gid: 1002
    - groups:
      - ops
      - deployment
    - require:
      - group: shepazu
      - group: ops
      - group: deployment

shepazu_keys:
  ssh_auth:
    - present
    - user: shepazu
    - enc: ssh-rsa
    - require:
      - user: shepazu
    - names:
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQC3XHXlQiIzF9QdvHs4Ybe8vXv4sfY6tdhpMlYDi7mD9ohPEd77xAdKo3ocKXWJ4Gjv3bf48s02YTqPCtCWMoTZKgdDsAbMcJPWnKOyawTjsTO2/EviXV+cGR3FY/HKgebozkAjxH7Ldo39PS0Xwx2VfaTcIJwzX3jDNNFgCCMwgMwRcwUC4DjkAMX5YLTn4n2BuEzAvxzlDijLI2CXAiCrtdkwOwdMqam8+4olKeFsn2YBTQC7PO3xoQ1FrUPjmo7JzGlyecHOxYDY5skE28bbwy6Eb6j9Ahxt2dYNh3cocLh4foRYPuebwDTCtOltGzHKb5RvT1WaeJ9SZLEzRtAB shepazu@unknown109adde84c2e
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDhull02mfjHWnCJjzBcDH25odEYue0a6bkKM1woyFWvl8KdUSzlLbhD3/8itxXcDC185e+rKBgIza1lMgB0dMhc+dv5Ph0OshX4QaYeQHSWsa4dwIdZP41NoHTppFcPJNLg/CreJC0no/TQmXQ/i6P3Ne7QQYJh/YKu9kM1UB0+LuNhnB9UDslDIZyEGKynqeVqdLgu7rRCqcBG/ldY439nwDI4QKxGw10qafKYyN196volv5BD5K6GAvHRv5FGf+yWDJ2vWsZWqvXraoZP/gEaWawVC5ddp4eg/o+bx91mIkHJTy4uGquCy/vTE3ZZAf1XX6ZZovpNaoCh17TtU63 shepazu@unknown109adde84c2e

yaron:
  group.present:
    - gid: 1003
  user.present:
    - shell: /bin/bash
    - uid: 1003
    - gid: 1003
    - groups:
      - ops
      - deployment
    - require:
      - group: yaron
      - group: ops
      - group: deployment

yaron_keys:
  ssh_auth:
    - present
    - user: yaron
    - enc: ssh-dss
    - require:
      - user: yaron
    - names:
      - AAAAB3NzaC1kc3MAAACBANKwx1cjjw732LqBBokF3eQQ5jUaMWKPw0j8wQdY3FeoFekQweTV9QKWlpncJXoS5Z9tAFYxC4vCNtJ5kx00WJIlGZtXNdRcNwYZ7eWLPcOydXzAVJI98YxYH4sHf51m4Aegs2Vi23fYnuyfasSXWPoZYBk5l3XyKruaKYDjzEg3AAAAFQD4iNRsG3OGs79mDwcNlJkjKtfHfQAAAIBsmsIa3EOgKIqIFyrysBJFbAx2zcG24v5vv137WncpKHC9FLxclai+/lMxLWllLgVQilddqr7ZGJh6HompHyfSDx+neCIbEll/jhaNmyB023Ujy/CbtX6Wx1Eru0nOSLbJAE38XmyA2jjoMVK3cZxgpQsQNqftQmPK5tobU13NlQAAAIBNkQA1QGhD2JPcd62UlALy4/Qb1yikz1EuuDrI6TXmaZ81ixW4WM8oG0uKrjCjyrAV2uKgDzRvsV8AqYBD6Er79O6XbQL5fFam+OGqiliEVml+2lGEJqNMwORlJhQvjCa61Z5puR2SeEm7QQbv+O/UU6eF/COEyEhTznjAuZIofA== ngrandy@server.discoursedb.org

cjgammon:
  group.present:
    - gid: 1004
  user.present:
    - shell: /bin/bash
    - uid: 1004
    - gid: 1004
    - groups:
      - ops
      - deployment
    - require:
      - group: cjgammon
      - group: ops
      - group: deployment

AAAAB3NzaC1yc2EAAAADAQABAAABAQC0jpRjfJ7/gjbLijYnKOt7/oTZDw+LeRg7wVejdUfVH+vS8U5Q+hOhR7wMZGFFwBqPNHTMOJRbiTPE5ng+jIsgkNy9O4y7yMGIGJqGQjVtpzDWnvbaki/K8Vbx/+k0xhEelZDipS2n0w0pcOBiJUrfmqeksQUvEyySfpQ1JdwNLwQtLghh68C923EeG3SZlGxRwnSmYQeVJPTl5gBXNKm4U/lnS0AcwbtCU1qp3ziz57s6OF6m+i/kfcmgM2Nmk914Q//kgmSjb5imfMxhH0Dfa1k6FCgpF94+pdprOSNVD7lLcacuDQP5yOw/fDmDi/QWmsPY/QTFzKOtNPwuG5Y5:
  ssh_auth:
    - present
    - user: cjgammon
    - enc: ssh-rsa
    - comment: GitHub@cjgammon
    - require:
      - user: cjgammon
