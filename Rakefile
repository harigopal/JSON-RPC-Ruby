require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |task|
  task.pattern = 'spec/*_spec.rb'
  task.rspec_opts = ['--backtrace']
end

task :default => :spec