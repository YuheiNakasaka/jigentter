# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|scss|js|html|png|jpg))).*}) { |m| "/assets/#{m[3]}" }
end

# rspec automatically executed with spork
guard 'spork', :rspec_env => { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch(%r{^config/routes\.rb$})
  watch('spec/spec_helper.rb')
  watch(%r{^spec/support/.+\.rb$})
  watch(%r{^spec/factories/.+\.rb$})
end
guard 'rspec', cmd: 'bundle exec rspec --drb --color --format documentation', version: 2,
  allow_start: false, all_after_pass: false, notification: false do
  watch(%r{app/models/.+})
  watch('app/controllers/apis_controller.rb')
  watch(%r{spec/.+/.+})
end