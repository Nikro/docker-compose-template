#!/bin/bash

# Step outside.
cd $(dirname "$0")/../..

echo $(pwd)

# Sync git.
git pull

# Sync images.
docker compose pull

docker compose rm -fs app web
docker volume rm "${PWD##*/}_app-code"

# Place everything back and reset permissions.
docker compose up -d
# Sometimes you have to fix the permissions.
#docker compose exec -T app bash -c "chown www-data:www-data /var/www/html/files -R"

# Deploy - this bit is for Drupal, but you can do whatever you want here.
#docker compose exec -T app bash -c "/root/.composer/vendor/bin/drush cc all"
#docker compose exec -T app bash -c "/root/.composer/vendor/bin/drush newrelic-deploy"
#docker compose exec -T app bash -c "/root/.composer/vendor/bin/drush fra -y"
#docker compose exec -T app bash -c "/root/.composer/vendor/bin/drush updb -y"
#docker compose exec -T app bash -c "/root/.composer/vendor/bin/drush cc all"