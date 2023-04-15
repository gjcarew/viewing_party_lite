#!/bin/bash
set -e
rm -f /myapp/tmp/pids/server.pid
bundle exec rake db:{drop,create,migrate,seed}
exec "$@"