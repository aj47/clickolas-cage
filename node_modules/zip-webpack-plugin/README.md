# zip-webpack-plugin

Webpack plugin to zip up emitted files.

Compresses all assets into a zip file.

## Installation

For Webpack 4 / 5:

`npm install --save-dev zip-webpack-plugin`

For Webpack 3:

`npm install --save-dev zip-webpack-plugin@2.0.0`

## Usage

**webpack.config.js**

```js
var ZipPlugin = require('zip-webpack-plugin');

module.exports = {
  // ...
  output: {
    path: path.join(__dirname, 'dist'),
    filename: 'bundle.js'
  },
  plugins: [
    new ZipPlugin({
      // OPTIONAL: defaults to the Webpack output path (above)
      // can be relative (to Webpack output path) or absolute
      path: 'zip',

      // OPTIONAL: defaults to the Webpack output filename (above) or,
      // if not present, the basename of the path
      filename: 'my_app.zip',

      // OPTIONAL: defaults to 'zip'
      // the file extension to use instead of 'zip'
      extension: 'ext',

      // OPTIONAL: defaults to the empty string
      // the prefix for the files included in the zip file
      pathPrefix: 'relative/path',

      // OPTIONAL: defaults to the identity function
      // a function mapping asset paths to new paths
      pathMapper: function(assetPath) {
        // put all pngs in an `images` subdir
        if (assetPath.endsWith('.png'))
          return path.join(path.dirname(assetPath), 'images', path.basename(assetPath));
        return assetPath;
      },

      // OPTIONAL: defaults to including everything
      // can be a string, a RegExp, or an array of strings and RegExps
      include: [/\.js$/],

      // OPTIONAL: defaults to excluding nothing
      // can be a string, a RegExp, or an array of strings and RegExps
      // if a file matches both include and exclude, exclude takes precedence
      exclude: [/\.png$/, /\.html$/],

      // yazl Options

      // OPTIONAL: see https://github.com/thejoshwolfe/yazl#addfilerealpath-metadatapath-options
      fileOptions: {
        mtime: new Date(),
        mode: 0o100664,
        compress: true,
        forceZip64Format: false,
      },

      // OPTIONAL: see https://github.com/thejoshwolfe/yazl#endoptions-finalsizecallback
      zipOptions: {
        forceZip64Format: false,
      },
    })
  ]
};
```
