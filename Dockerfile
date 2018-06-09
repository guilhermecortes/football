FROM elixir:latest

# Install hex
RUN mix local.hex --force

# Install the Phoenix framework
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

# Install NodeJS 8.x and the NPM
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y -q nodejs

# Install rebar
RUN mix local.rebar --force

# Set /opt as workdir
WORKDIR /opt
