require 'cgi'

module Cartbotsy
  class Parser
    attr_reader :socket, :token, :channel_, :channel_name, :username, :message, :error,
      :product_link, :product_amount

    def initialize(socket)
      @socket = socket
      @errors = []
    end

    def parse
      query_hash = hash_from_socket
      parse_hash(query_hash)
      parse_message
      return @errors unless @errors.empty?
      return_hash
    end

    private

    def hash_from_socket
      response = []
      while line = socket.gets
        response << line
      end
      CGI::parse(response.last)
    end

    def parse_hash(hash)
      @token = hash["token"].first
      @errors << 1301 unless token == Cartbotsy::Config::WEBHOOK_TOKEN
      @channel_name = hash["channel_name"].first
      @errors << 1302 unless Cartbotsy::Config::AVAILABLE_CITIES.include?(channel_name)
      @username = hash["user_name"].first
      @message = hash["text"].first
    end

    def parse_message
      message_split = message.split(' ')
      trigger_word = message_split[0]
      @product_link = message_split[1]
      @product_amount = message_split[2].to_i
      @errors << 1401 if product_amount <= 0
    end

    def return_hash
      {
        product_link: @product_link,
        product_amount: @product_amount,
        channel_name: @channel_name,
        username: @username,
      }
    end
  end
end
