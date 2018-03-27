FROM ruby:2.3-alpine

MAINTAINER  Sharetribe Team <team@sharetribe.com>

RUN apk add --update nodejs g++ make

# Add user for running the app
RUN adduser -D app

COPY Gemfile Gemfile.lock /opt/app/
WORKDIR /opt/app
USER app
RUN bundle install

COPY . /opt/app
USER root
RUN chown -R app:app /opt/app
USER app

EXPOSE 4567

CMD ["bundle", "exec", "middleman", "server", "--watcher-force-polling"]
