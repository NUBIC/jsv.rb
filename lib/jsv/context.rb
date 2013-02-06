require 'execjs'

module JSV
  class Context
    JSV_PATH = File.expand_path('../../../js/build/jsv.rb.js', __FILE__)

    attr_reader :execjs

    def initialize
      @execjs = ExecJS.compile(File.read(JSV_PATH))

      setup_context
    end

    def environment(env = nil)
      jsenv = env ? "'#{env}'": ''
      @execjs.exec(%Q{env = jsv.createEnvironment(#{jsenv});})

      self
    end

    def validate(json, schema)
      @execjs.call('setInstance', json)
      @execjs.call('setSchema', schema)
      @execjs.call('validate')
      @execjs.eval('report.errors == 0')
    end

    def errors
      @execjs.eval('report.errors')
    end

    private

    VARIABLES = %w(
      env
      instance
      jsv
      report
      schema
      setInstance
      setSchema
      validate
    )

    def setup_context
      VARIABLES.each { |var| @execjs.exec("#{var} = undefined") }

      @execjs.exec(%Q{
        this.require.define();
        jsv = this.require('./jsv').JSV;

        setInstance = function (inp) {
          instance = JSON.parse(inp);
        };

        setSchema = function (inp) {
          schema = JSON.parse(inp);
        };

        validate = function () {
          report = env.validate(instance, schema);
        };
      })
    end
  end
end
