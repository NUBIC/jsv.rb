JS_DIR = File.expand_path('../js', __FILE__)

namespace :js do
  task :build do
    sh "node #{JS_DIR}/stitcher.js"
  end

  task :compress => :build do
    sh "closure-compiler --compilation_level SIMPLE_OPTIMIZATIONS #{JS_DIR}/build/jsv.rb.js > #{JS_DIR}/build/cc.js"
    mv "#{JS_DIR}/build/cc.js", "#{JS_DIR}/build/jsv.rb.js"
  end
end
