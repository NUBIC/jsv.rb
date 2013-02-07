require 'jsv/report'

module JSV
  class Environment
    attr_reader :env_id
    attr_reader :additional_schemas

    def initialize(context, env_id)
      @context = context
      @env_id = env_id
      @additional_schemas = {}
    end

    def validate(json, schema)
      result = @context.validate(self, json, schema)

      Report.new(result)
    end

    def create_schema(data, schema, uri)
      @additional_schemas[uri] = { 'schema' => schema, 'data' => data }
    end
  end
end
