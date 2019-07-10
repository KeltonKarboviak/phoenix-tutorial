#!/bin/sh
# Adapted from Alex Kleissner's post, Running a Phoenix 1.3 project with docker-compose
# https://medium.com/@hex337/running-a-phoenix-1-3-project-with-docker-compose-d82ab55e43cf

set -e

# Ensure the app's dependencies are installed
# mix deps.get

# Prepare Dialyzer if the project has Dialyxer set up
if mix help dialyzer >/dev/null 2>&1; then
  echo "\n> Found Dialyxer: Setting up PLT..."
  mix do deps.compile, dialyzer --plt
else
  echo "\n> No Dialyxer config: Skipping setup..."
fi

# Install JS libraries
echo "\n> Installing JS..."
cd assets && yarn install
cd ..

# Wait for Postgres to become available.
until psql -h db -U "postgres" -c '\q' 2>/dev/null; do
  >&2 echo "> Postgres is unavailable - sleeping"
  sleep 1
done

echo "\n> Postgres is available: continuing with database setup..."

# Potentially Set up the database
mix ecto.create
mix ecto.migrate

# "Prove" that install was successful by running the tests
echo "\n> Testing the installation..."
mix test

# Start the phoenix web server
echo "\n> Launching Phoenix web server..."
exec mix phx.server
