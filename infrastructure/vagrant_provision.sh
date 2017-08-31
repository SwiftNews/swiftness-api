#!/bin/sh

ERLANG_VERSION=20.0-1
ELIXIR_VERSION=1.5.1

# Note: password is for postgres user "postgres"
POSTGRES_DB_PASS=postgres
POSTGRES_VERSION=9.6+184.pgdg14.04+1

# Set language and locale
apt-get install -y language-pack-en
locale-gen --purge en_US.UTF-8
echo "LC_ALL='en_US.UTF-8'" >> /etc/environment
dpkg-reconfigure locales

# Install basic packages
# inotify is installed because it's a Phoenix dependency
apt-get -qq update
apt-get install -y \
wget \
git \
unzip \
build-essential \
ntp \
inotify-tools

# Install Erlang
echo "deb http://packages.erlang-solutions.com/ubuntu trusty contrib" >> /etc/apt/sources.list && \
apt-key adv --fetch-keys http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc && \
apt-get -qq update
apt-get install -y \
erlang=1:$ERLANG_VERSION \

# Install Elixir
cd / && mkdir elixir && cd elixir && \
wget -q https://github.com/elixir-lang/elixir/releases/download/v$ELIXIR_VERSION/Precompiled.zip && \
unzip Precompiled.zip && \
rm -f Precompiled.zip && \
ln -s /elixir/bin/elixirc /usr/local/bin/elixirc && \
ln -s /elixir/bin/elixir /usr/local/bin/elixir && \
ln -s /elixir/bin/mix /usr/local/bin/mix && \
ln -s /elixir/bin/iex /usr/local/bin/iex

# Install local Elixir hex and rebar for the vagrant user
su - vagrant -c '/usr/local/bin/mix local.hex --force && /usr/local/bin/mix local.rebar --force'

# Postgres
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
apt-get -qq update
apt-get -y install postgresql=$POSTGRES_VERSION postgresql-contrib=$POSTGRES_VERSION

PG_CONF="/etc/postgresql/$POSTGRES_VERSION/main/postgresql.conf"
echo "client_encoding = utf8" >> "$PG_CONF" # Set client encoding to UTF8
service postgresql restart

cat << EOF | su - postgres -c psql
ALTER USER postgres WITH ENCRYPTED PASSWORD '$POSTGRES_DB_PASS';
EOF

# Install nodejs and npm
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install -y \
nodejs

# Install imagemagick
apt-get install -y imagemagick

echo y | su - vagrant -c 'mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez'

# If seeds.exs exists we assume it is a Phoenix project
if [ -f /vagrant/priv/repo/seeds.exs ]
  then
    # Set up and migrate database
    su - vagrant -c 'cd /vagrant && mix deps.get && mix ecto.create && mix ecto.migrate'
    # Run Phoenix seed data script
    su - vagrant -c 'cd /vagrant && mix run priv/repo/seeds.exs'
fi
