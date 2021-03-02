/home/kiosk/.xinitrc:
  file.managed:
    - source: salt://kiosk/files/xinitrc
    - mode: 544
    - user: kiosk
    - group: users

gdm_displaymanager:
  file.replace:
    - name: /etc/sysconfig/displaymanager
    - pattern: '^DISPLAYMANAGER_AUTOLOGIN.*'
    - repl: 'DISPLAYMANAGER_AUTOLOGIN="kiosk"'

/home/kiosk/.vnc:
  file.directory:
    - user: kiosk
    - group: users
    - mode: 750
    - makedirs: True

/home/kiosk/.vnc/passwd:
  file.managed:
    - source: salt://kiosk/files/vnc-passwd
    - mode: 600
    - user: kiosk
    - group: users