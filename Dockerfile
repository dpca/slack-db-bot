FROM ruby:2.3

WORKDIR /tmp
COPY Gemfile /tmp/
COPY Gemfile.lock /tmp/
RUN bundle install

RUN mkdir -p /db-bot
WORKDIR /db-bot
COPY . /db-bot/

CMD ["ruby", "bin/run"]
