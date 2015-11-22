# Learn more: http://github.com/javan/whenever
set :output, '/var/log/cron'
set :environment, :production

every '*/2 * * * *' do
  rake 'twitter:delete["production"]'
end