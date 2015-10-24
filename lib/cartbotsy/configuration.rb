module Cartbotsy
  class Configuration
    attr_accessor :api_token, :webhook_token, :app_url, :available_cities, :botname

    def initialize(api_token = '', webhook_token = '', app_url = '', available_cities = [], botname = nil)
      @api_token = api_token
      @webhook_token = webhook_token
      @app_url = app_url
      @available_cities = available_cities
      @botname = botname || 'Cartbotsy'
    end
  end
end

