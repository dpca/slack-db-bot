class SlackMessenger
  attr_reader :client

  def initialize(slack_client)
    @client = slack_client
  end

  def send(msg)
    client.chat_postMessage(
      channel: ENV['SLACK_CHANNEL'],
      text: msg,
      as_user: false,
      username: ENV['SLACK_USERNAME'],
      icon_emoji: ENV['SLACK_ICON_EMOJI'],
    )
  end
end
