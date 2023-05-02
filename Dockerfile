FROM ruby:2.7.4

# Get berglas
COPY --from=gcr.io/berglas/berglas:latest /bin/berglas /bin/berglas

# Install javascript runtime (can be skipped if this is an API)
RUN apt-get update -qq && apt-get install -y nodejs

# Install bundler
RUN gem update --system
RUN gem install bundler

# Install production dependencies.
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
ENV BUNDLE_FROZEN=true
RUN bundle install

# Copy local code to the container image.
COPY . ./

# Environment
ENV RAILS_ENV production
ENV RAILS_MAX_THREADS 60
ENV RAILS_LOG_TO_STDOUT true

# This is a link to the secrets location. Sub this with your own link.
ENV MOVIES_API_KEY_LINK vp-secret-bucket/movies-api-key
ENV RAILS_MASTER_KEY_LINK vp-secret-bucket/master.key
ENV DB_USERNAME_LINK vp-secret-bucket/prod-db-username
ENV DB_PW_LINK vp-secret-bucket/prod-db-password
# Run the web service on container startup.
CMD ["bash", "entrypoint.sh"]