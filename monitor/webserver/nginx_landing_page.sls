
nginx:
  pkg:
    - installed

openssl:
  pkg:
    - installed

/usr/share/nginx/html/id:
  file:
    - managed
    - makedirs: true
    - contents: '{{ grains.id }}'
    - require:
      - pkg: nginx

/usr/share/nginx/html:
  file:
    - recurse
    - source: salt://monitor/var/www/html
    - template: jinja
    - makedirs: true
    - require:
      - pkg: nginx

/etc/nginx/conf.d/:
  file:
    - recurse
    - makedirs: true
    - template: jinja
    - clean: true
    - source: salt://monitor/etc/nginx/sites-enabled
    - require:
      - file: /usr/share/nginx/html/id

/etc/nginx/sites-available:
  file:
    - absent

/etc/nginx/sites-enabled:
  file:
    - absent

nginx-svc:
  service:
    - running
    - name: nginx
    - watch:
      - file: /usr/share/nginx/html/id
      - file: /etc/nginx/conf.d/
    - require:
      - pkg: nginx

/var/log/nginx:
  file.directory:
    - mode: 755
    - require:
      - pkg: nginx

