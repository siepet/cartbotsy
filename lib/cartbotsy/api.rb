require 'httmultiparty'

module Cartbotsy
  class API
    BASE_URI = 'http://slack.com/api/'
    attr_reader :token

    def initialize(token)
      @token = token
    end

    def get_objects(method, key)
      HTTMultiParty.get(BASE_URI + "/#{method}", query: { token: token }).tap do |response|
        response[key].find { |e| e['name'] == key }
      end
    end

    def channels
      @channels ||= get_objects('channels.list', 'channels')
    end

    def users
      @users ||= get_objects('users.list', 'users')
    end

    def post_message(message, channel)
      HTTMultiParty.get(BASE_URI + "chat.postMessage", query: post_query(channel, message))
    end

    private

    def post_query(channel, text)
      {
        token: Cartbotsy::Config::API_TOKEN,
        channel: channel,
        text: text,
        username: 'pipguru',
      }
    end
  end
end
