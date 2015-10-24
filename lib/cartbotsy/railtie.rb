require 'rails'

module Cartbotsy
  class Railtie < Rails::Railtie
    rake_tasks do
      load '../tasks/tasks.rb'
    end
  end
end

