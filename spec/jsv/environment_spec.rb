require 'spec_helper'

module JSV
  describe Environment do
    let(:context) { JSV::Context.new }

    describe 'for Draft 03' do
      let(:env) { context.create_environment('json-schema-draft-03') }

      describe '#validate' do
        let(:schema) do
          %Q{
            {
                "properties": {
                    "foo": {
                        "type": "integer"
                    }
                }
            }
          }
        end

        it 'returns a report with zero errors for valid JSON' do
          report = env.validate('{"foo":3}', schema)

          report.should_not have_errors
        end

        it 'returns a report with errors for invalid JSON' do
          report = env.validate('{"foo":"nope"}', schema)

          report.should have_errors
        end
      end

      describe '#create_schema' do
        let(:referenced_schema) do
          %Q{
              {
                  "properties": {
                      "bar": {
                          "type": "integer"
                      }
                  }
              }
          }
        end

        let(:schema) do
          %Q{
              {
                  "properties": {
                      "foo": {
                          "extends": {
                              "$ref": "urn:fooSchema#"
                          }, 
                          "type": "object"
                      }
                  }
              }
          }
        end

        let(:json) do
          %Q{
            { "foo": { "bar": "baz" } }
          }
        end

        it 'makes a schema available for use in validation' do
          env.create_schema(referenced_schema, nil, 'urn:fooSchema#')

          report = env.validate(json, schema)
          report.errors.first['message'].should =~ /not a required type/
        end
      end
    end
  end
end
