begin
  require 'cucumber/rake/task'
  require 'rspec/core/rake_task'
  
  require 'ci/reporter/rake/rspec'

  namespace :ci do
    Cucumber::Rake::Task.new(:cucumber_run) do |t|
      t.profile = 'ci'
      t.rcov = true
      t.rcov_opts = %w{--rails --exclude osx\/objc,gems\/,spec\/,features\/ --aggregate coverage.data}
      t.rcov_opts << %[-o "coverage"]
    end
    
    RSpec::Core::RakeTask.new(:rspec_run) do |t|
      t.pattern = FileList['spec/**/*_spec.rb']
      t.rcov = true
      t.rcov_opts = %w{--rails --exclude osx\/objc,gems\/,spec\/}
    end

    desc "Run both specs and features to generate aggregated coverage"
    task :all do |t|
      ENV['STEP']= '14'
      Rake::Task["db:rollback"].invoke
      ENV.delete 'STEP'
      Rake::Task["db:migrate"].invoke
      Rake::Task["rcov:clean"].invoke
      Rake::Task["ci:cucumber_run"].invoke
      Rake::Task["ci:rspec_run"].invoke
    end
  
    ENV["CI_REPORTS"] = "reports/spec-xml"
    task :rspec do |t|
      Rake::Task["ci:setup:rspec"].invoke
      Rake::Task["ci:rspec_run"].invoke
    end


  end
rescue
  desc 'ci rake task not available (cucumber or rspec not installed)'
  task :ci do
    abort 'CI rake task is not available. Be sure to install cucumber and/or rspec as a gem or plugin'
  end
end