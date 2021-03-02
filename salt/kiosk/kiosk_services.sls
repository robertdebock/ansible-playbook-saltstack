display-manager:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/sysconfig/displaymanager
      - file: /home/kiosk/.xinitrc
