require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task default: []

begin
  require 'rubocop'
  require 'rspec/core/rake_task'

  desc 'Run rubocop'
  task :rubocop do
    exit RuboCop::CLI.new.run(%w(--rails))
  end

  namespace :db do
    desc 'Runs db:drop db:create db:migrate db:seed'
    task rebuild: [:drop, :create, :migrate, :seed]
  end

  Rake::Task[:default].clear
  task default: [:spec, :rubocop]
rescue LoadError
  STDOUT.print 'Skipping rubocop loading'
end
