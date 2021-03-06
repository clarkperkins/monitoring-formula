
#
# This installs the Uchiwa dashboard for Sensu and all of it's dependencies.
#

uchiwa-pkg:
  pkg:
    - installed
    - name: uchiwa

/etc/sensu/uchiwa.json:
  file:
    - managed
    - source: salt://monitor/etc/sensu/uchiwa.json
    - user: uchiwa
    - group: sensu
    - template: jinja
    - require:
      - pkg: uchiwa-pkg

uchiwa-svc:
  service:
    - running
    - name: uchiwa
    - enable: true
    - require:
      - file: /etc/sensu/uchiwa.json

