locale:
  pkg.installed:
    - refresh: True
    - skip_verify: True
    - pkgs:
      - language-pack-en

/etc/environment:
  file.append:
    - text: LC_ALL='en_US.UTF-8'

    