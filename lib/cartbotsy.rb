require "socket"
require "./cartbotsy/api"
require "./cartbotsy/config"
require "./cartbotsy/parser"
require "pry"

module Cartbotsy
  class Worker

    def self.start
      server = TCPServer.new(3001)
      loop do
        puts 'Waiting for hook...'
        client = server.accept
        if client
          puts 'Request received... parsing...'
          parsed = Cartbotsy::Parser.new(client).parse
          if parsed.is_a?(Hash)
            handle_success(parsed)
          else
            handle_failure(parsed)
          end
          puts 'Request parsed...'
        end
      end
    end

    private

    def self.parse_socket(socket)
      response = []
      while line = socket.gets
        response << line
      end
      CGI::parse(response.last)
    end

    def self.handle_success(parsed_hash)
      message = "#{parsed_hash[:product_amount]} produkty dodane do " +
        "koszyka dla miasta #{parsed_hash[:channel_name].capitalize} przez użytkownika #{parsed_hash[:username]}."
      Cartbotsy::API.new(Cartbotsy::Config::API_TOKEN).post_message(message, "##{parsed_hash[:channel_name]}")
      puts 'Message to Slack sent: ' + message
    end

    def self.handle_failure(parsed_hash)
      message = "COS ZEPSUŁEŚ KOLEGO #{parsed_hash[:username]}"
      Cartbotsy::API.new(Cartbotsy::Config::API_TOKEN).post_message(message, "##{parsed_hash[:channel_name]}")
    end
  end
end
Cartbotsy::Worker.start
