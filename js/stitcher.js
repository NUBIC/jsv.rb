// vim:ts=2:sw=2:et:tw=78
//
(function () {
  "use strict";

  var buildDir, fs, pkg, stitch;

  stitch = require('stitch');
  fs = require('fs');

  buildDir = __dirname + "/build";

  pkg = stitch.createPackage({
    paths: [
      __dirname + "/../vendor/JSV/lib",
      __dirname + "/lib"
    ]
  });

  pkg.compile(function(err, source) {
    fs.writeFile(buildDir + "/jsv.rb.js", source, function(err) {
      if (err) {
        throw err;
      }
    });

    if (err) {
      throw err;
    } else {
      console.log('OK');
    }
  });
}());

/* jslint indent: 2 */
