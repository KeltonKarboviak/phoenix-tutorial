##############################
FROM node

# COPY ./ /app/

# WORKDIR /app/assets

# RUN npm install

# RUN node node_modules/webpack/bin/webpack.js --mode development

##############################
FROM elixir:1.9

WORKDIR /app

COPY mix* ./

# The --force flag does the installation
# without a shell prompt
RUN mix local.hex --force \
    && mix local.rebar --force \
    && mix deps.get \
    && mix deps.compile

COPY . .

CMD [ "mix", "phx.server" ]
