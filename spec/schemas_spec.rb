RSpec.describe Schemas do
  it "validates schema format" do
    schema = {
      "$schema" => "http://alephri.com/root_definition.json",
      type: "object",
      properties: {
        meta: {
          type: "object",
          properties: {
            store: {
              type: "string"
            },
          }
        },

        properties: {
          type: "object",
          patternProperties: {
            "^[a-z_]+$" => {
              type: "object",
              properties: {
                type: {
                  type: "string",
                  enum: ["string", "boolean", "integer", "float", "array", "object", "latlon"],
                },
                description: {
                  type: "string"
                },
                label: {
                  type: "object",
                  propertiesNames: {
                    pattern: "^(es|en)$"
                  }
                },
                validators: {
                  type: "array",
                  items: {
                    type: "object",
                    properties: {
                      name: {
                        type: "string",
                        enum: ["required", "format"]
                      },
                      arg1: {
                        type: ["string", "boolean", "numeric"]
                      }
                    },
                    required: ["name"],
                    additionalProperties: false,
                  }
                },
              },
              required: [ "type" ],
            }
          }, # patternProperties
        }, # properties
        additionalProperties: false,
      },
    }

    data = {
      "meta": {
        "store": "users",
      },
      "properties": {
        "name": {
          "type": "string",
          "description": "The user name",
          "label": { "es": "Nombre", "en": "Name" },
          "validators": [
            {"name": "required", "arg1": true},
            {"name": "format", "arg1": "^[\d]{2}$"},
          ],
        }
      }
    }

    errors = JSON::Validator.fully_validate(schema, data)
    puts errors
    expect(errors).to be_empty
  end
end
