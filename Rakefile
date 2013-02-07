require 'rspec/core/rake_task'

JS_DIR = File.expand_path('../js', __FILE__)

RSpec::Core::RakeTask.new(:spec)

namespace :js do
  task :build do
    sh "node #{JS_DIR}/stitcher.js"
  end
end

task :default => :spec
