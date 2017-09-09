elixir:
  pkgrepo.managed:
    - humanname: Erlang Solutions PPA
    - name: deb http://packages.erlang-solutions.com/ubuntu trusty contrib
    - dist: trusty
    - key_url: http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc
    - require_in:
      - pkg: elixir

  pkg.installed:
    - refresh: True
    - skip_verify: True
    - pkgs:
      - elixir
      - esl-erlang