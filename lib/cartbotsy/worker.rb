module Cartbotsy
  class Worker
    class << self
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

      def handle_success(parsed_hash)
        message = "#{parsed_hash[:product_amount]} products added to " +
          "cart in #{parsed_hash[:channel_name].capitalize} city by user #{parsed_hash[:username]}."
        api_call(parsed_hash[:channel_name], parsed_hash[:product_link], parsed_hash[:product_amount])
        Cartbotsy::API.new(Cartbotsy.config.api_token).post_message(message, "##{parsed_hash[:channel_name]}")
        puts 'Message to Slack sent: ' + message
      end

      def handle_failure(parsed_hash)
        message = "You broke something, buddy! #{parsed_hash[:username]}"
        Cartbotsy::API.new(Cartbotsy.config.api_token).post_message(message, "##{parsed_hash[:channel_name]}")
      end

      def api_call(channel_name, product_link, product_amount)
        api_hash = {
          region_name: channel_name,
          product_link: product_link,
          product_amount: product_amount,
        }
        puts HTTMultiParty.post(Cartbotsy.config.app_url + "/api/update", query: api_hash)
      end
    end
  end
end
