postgres-server:
  pkgrepo.managed:
    - name: deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main
    - dist: trusty-pgdg
    - file: /etc/apt/sources.list.d/psql.list
    - key_url: https://www.postgresql.org/media/keys/ACCC4CF8.asc
    - require_in:
      - pkg: postgres-server

  pkg.installed:
    - refresh: True
    - version: 10+186.pgdg14.04+1
    - names:
      - postgresql
      - postgresql-contrib

postgres:
  postgres_user.present:
    - password: postgres

    - require:
      - pkg: postgres-server