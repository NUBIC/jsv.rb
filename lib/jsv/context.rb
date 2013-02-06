require 'execjs'

module JSV
  class Context
    JSV_PATH = File.expand_path('../../../js/build/jsv.rb.js', __FILE__)

    attr_reader :execjs

    def initialize
      @execjs = ExecJS.compile(File.read(JSV_PATH))

      setup_context
    end

    def environment(env)
      @execjs.exec(%Q{
        env = jsv.createEnvironment('#{env}');
      })

      self
    end

    def validate(json, schema)
      @execjs.call('setInstance', json)
      @execjs.call('setSchema', schema)
      @execjs.call('validate')
    end

    private

    def setup_context
      %w(env instance jsv schema setInstance setSchema validate).each do |gvar|
        @execjs.eval("#{gvar} = undefined")
      end

      @execjs.exec(%Q{
        jsv = require('./jsv').JSV;

        setInstance = function (json) {
          instance = JSON.parse(json);
        };

        setSchema = function (schema) {
          schema = JSON.parse(schema);
        };

        validate = function () {
          env.validate(instance, schema);
        };
      })
    end
  end
end
