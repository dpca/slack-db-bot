[![Code Climate](https://codeclimate.com/github/dpca/slack-db-bot/badges/gpa.svg)](https://codeclimate.com/github/dpca/slack-db-bot)

* * *

# slack-db-bot

Detects database table changes and posts about them in a channel

## Setup

Set the following in `.env` to set up slack messaging:

* SLACK_TOKEN
* SLACK_CHANNEL
* SLACK_USERNAME
* SLACK_ICON_EMOJI

Make a `config/connections.rb` file to set up the database connections you want
to watch, and then define a `CONNECTIONS` array containing those connection
classes. This is necessary because ActiveRecord does not allow connections on
anonymous classes.

```ruby
class DB < ActiveRecord::Base
  self.abstract_class = true
  establish_connection(
    adapter: 'mysql2',
    host: $HOST,
    database: $DATABASE,
    username: $USERNAME,
    password: $PASSWORD
  )
end

CONNECTIONS = [DB]
```

Finally, run `bin/setup` to create the initial table cache (stored in the
`tmp/` folder).

## Run

```
bin/run
```

Or if you prefer to use Docker:

```
docker build -t db-bot .
docker run -v $(pwd):/db-bot db-bot bin/setup
docker run -v $(pwd):/db-bot db-bot
```

## Cron

Run the db-bot automatically by adding something like the following to your
crontab (`crontab -e`):

```
0 * * * * cd /home/USER/slack-db-bot && /usr/local/bin/ruby bin/run >> /home/USER/slack-db-bot/cronOutput.txt 2>&1
```
