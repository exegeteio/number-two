#### Base rails image, used for `rails new` and other commands.
FROM ruby:2.7-alpine AS rails

RUN apk add --update --no-cache --quiet \
    build-base \
    gcompat \
    nodejs-current \
    postgresql-dev \
    sqlite-dev \
    tzdata \
    yarn

RUN echo -e "source 'https://rubygems.org'\ngem 'rails'" > /Gemfile
RUN bundle install --quiet

FROM rails as rails-builder

RUN apk add --update --no-cache --quiet \
    build-base \
    nodejs-current \
    postgresql-dev \
    python3 \
    sqlite-dev \
    tzdata \
    yarn

WORKDIR /app/

COPY Gemfile Gemfile.lock /app/
RUN bundle config --global frozen 1 \
    && bundle install --quiet -j4 --retry 3 \
    # Remove unneeded files (cached *.gem, *.o, *.c)
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete

EXPOSE 5000
CMD bundle exec rails server -b 0.0.0.0 -p 5000

#### Builder is used to build assets and delete side effects.
FROM rails-builder AS builder

COPY Gemfile Gemfile.lock /app/
RUN rm -rf /usr/local/bundle \
    && bundle config --global frozen 1 \
    && bundle config set without 'development test' \
    && bundle install --quiet -j4 --retry 3 \
    # Remove unneeded files (cached *.gem, *.o, *.c)
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete

COPY package.json yarn.lock /app/
RUN yarn install

COPY ./ /app/
RUN RAILS_ENV=production SECRET_KEY_BASE=not_for_prod bundle exec rake assets:precompile
RUN rm -rf node_modules tmp/cache vendor/assets lib/assets spec

# Final image
FROM ruby:2.7-alpine AS final

# Set Rails env
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true
ENV EXECJS_RUNTIME Disabled

RUN apk add --update --no-cache postgresql-client tzdata

# Add user
RUN addgroup -g 1000 -S app \
    && adduser -u 1000 -S app -G app
USER app

WORKDIR /app

# Copy app with gems from former build stage
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder --chown=app:app /app /app
