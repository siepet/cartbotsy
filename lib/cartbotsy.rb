require "socket"
require "./cartbotsy/api"
require "./cartbotsy/config"
require "./cartbotsy/parser"
require "./cartbotsy/worker"
require "pry"

Cartbotsy::Worker.start
