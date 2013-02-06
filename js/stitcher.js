var buildDir, fs, pkg, stitch;

stitch = require('stitch');
fs = require('fs');

buildDir = __dirname + "/build";

pkg = stitch.createPackage({
  paths: [__dirname + "/../vendor/JSV/lib"]
});

pkg.compile(function(err, source) {
  fs.writeFile(buildDir + "/jsv.rb.js", source, function(err) {
    if (err) {
      throw err;
    }
   console.log('OK');
  });
});
