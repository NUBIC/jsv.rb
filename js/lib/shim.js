(function () {
  "use strict";

  function validate(envId, additionalSchemas, json, schema) {
    var JSV, env, parsedJson, parsedSchema, report,
      uri, schemaSpec, schemaSchema;

    JSV = require('jsv').JSV;

    if (!envId) {
      env = JSV.createEnvironment();
    } else {
      env = JSV.createEnvironment(envId);
    }

    for (uri in additionalSchemas) {
      if (additionalSchemas.hasOwnProperty(uri)) {
        schemaSpec = additionalSchemas[uri];
        parsedJson = JSON.parse(schemaSpec.data);

        // JSV assigns special meaning to undefined, but we can't pass
        // undefined from Ruby
        schemaSchema = schemaSpec.schema || undefined;
        env.createSchema(parsedJson, schemaSchema, uri);
      }
    }

    parsedJson = JSON.parse(json);
    parsedSchema = JSON.parse(schema);

    report = env.validate(parsedJson, parsedSchema);

    return {
      "errors": report.errors
    };
  }

  exports.validate = validate;
}());

/*jslint indent: 2*/
/*global require: false, exports: false*/
// vim:ts=2:sw=2:et:tw=78
