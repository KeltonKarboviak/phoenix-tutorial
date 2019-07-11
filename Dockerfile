##############################
FROM node

# COPY ./ /app/

# WORKDIR /app/assets

# RUN npm install

# RUN node node_modules/webpack/bin/webpack.js --mode development

##############################
FROM elixir:1.9

EXPOSE 4000

WORKDIR /app

# Setup for node + yarn
RUN curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh \
    && bash nodesource_setup.sh \
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt update \
    && apt install -y \
        inotify-tools \
        nodejs \
        postgresql-client \
        yarn

COPY mix* ./

# The --force flag does the installation
# without a shell prompt
RUN mix local.hex --force \
    && mix local.rebar --force \
    && mix archive.install hex phx_new 1.4.9 --force \
    && mix deps.get \
    && mix deps.compile

COPY . .

CMD [ "./run.sh" ]
