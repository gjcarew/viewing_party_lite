# !/bin/bash
set -e

# Environment setup
# This is where you define the environment variables you will need
export MOVIES_API_KEY=$(berglas access $MOVIES_API_KEY_LINK)
export RAILS_MASTER_KEY=$(berglas access $RAILS_MASTER_KEY_LINK)
export PROD_DB_USERNAME=$(berglas access $DB_USERNAME_LINK)
export PROD_DB_PASSWORD=$(berglas access $DB_PW_LINK)

# Run deploy tasks in warmup mode. 
# These will be passed as environmental variables in the build step
if [ "$WARMUP_DEPLOY" == "true" ]; then
  # The traditional Rails migration. 
  # As you deploy new versions, this will update the DB. 
  echo "Warmup deploy: running migrations..."
  bundle exec rake db:migrate
  echo "Warmup deploy: migrations done"
fi

if [ "$FIRST_DEPLOY" == "true" ]; then
  # This only needs to run on the database once.
  echo "First deploy: seeding DB..."
  bundle exec rake db:migrate
  echo "first deploy: seeding done"
fi

# Precompile assets (can be skipped for an API)

RAILS_ENV=production bundle exec rails assets:precompile

# Start Puma
mkdir -p tmp/pids
bundle exec puma -p 8080