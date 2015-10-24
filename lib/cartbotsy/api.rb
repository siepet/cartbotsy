require 'httmultiparty'

module Cartbotsy
  class API
    BASE_URI = 'http://slack.com/api/'
    attr_reader :token

    def initialize(token)
      @token = token
    end

    def post_message(message, channel)
      HTTMultiParty.get(BASE_URI + "chat.postMessage", query: post_query(channel, message))
    end

    private

    def post_query(channel, text)
      {
        token: Cartbotsy.config.api_token,
        channel: channel,
        text: text,
        username: Cartbotsy.config.botname,
      }
    end
  end
end
