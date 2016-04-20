set :output, 'log/cron.log'

every :day, :at => '12:00pm' do
  runner "CranScraper.new"
end
