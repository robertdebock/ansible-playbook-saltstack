# Load yml files based on the fqdn from the config directory.
{% set server_properties_file = (slspath + '/config/' + grains['fqdn'] + '.yml') %} 
{% import_yaml server_properties_file as server_properties %}

/home/kiosk/.xinitrc:
  file.managed:
    - source: salt://kiosk/templates/xinitrc.j2
    - template: jinja
    - mode: 544
    - user: kiosk
    - group: users
    - context:
        url: {{ server_properties.url }}

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

/etc/cron.d/reboot:
  file.managed:
    - source: salt://kiosk/files/cron-reboot
