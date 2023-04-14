set -e
rm -f /myapp/tmp/pids/server.pid

# Run migrations
echo "Running migrations" 
bundle exec rake db:migrate
echo "complete"

# Start the rails server (puma) on port 8080
bundle exec puma -p 8080

exec "$@"