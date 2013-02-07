require 'execjs'
require 'jsv/environment'

module JSV
  ##
  # Loads the JSV library code and a Javascript <-> Ruby shim.
  #
  # Usage:
  #
  #     jsv = JSV::Context.new
  #     env = jsv.create_environment
  #     report = env.validate(json, schema)
  #
  #     report.has_errors?
  #
  #     # Error objects are JSON objects as described in JSV's README.
  #     report.errors  # => [error object]
  class Context
    JS_CODE_PATH = File.expand_path('../../../js/build/jsv.rb.js', __FILE__)

    def initialize
      @execjs = ExecJS.compile(File.read(JS_CODE_PATH))
    end

    def create_environment(env = nil)
      Environment.new(self, env)
    end

    def validate(env, json, schema)
      @execjs.call('this.require("shim").validate',
                   env.env_id,
                   env.additional_schemas,
                   json,
                   schema)
    end

    # Public: A custom inspect.
    #
    # When using the RubyRacer runtime, weak references to Ruby wrappers for
    # Javascript objects will show up in inspect output.  When those wrappers
    # are GCed, references will break and Object#inspect breaks too.
    #
    # This implementation of inspect avoids the problem by not inspecting the
    # execjs context.  (The context still appears to be fully functional after
    # GC.)
    def inspect
      "#<#{self.class.name}:0x#{object_id.to_s(16)}>"
    end
  end
end
