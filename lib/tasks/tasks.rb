namespace :cartbotsy do
  desc 'Start Cartbotsy worker.'
  task :work do
    Cartbotsy::Worker.start
  end
end
