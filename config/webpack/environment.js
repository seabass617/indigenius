
// config/webpack/environment.js
const { environment } = require('@rails/webpacker')

// Bootstrap 4 has a dependency over jQuery & Popper.js:
const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
)

//this line is to fix a weird bug on Saraah's map 
//https://github.com/mapbox/mapbox-gl-js/issues/8574 
//https://github.com/mapbox/mapbox-gl-js/issues/3422 
environment.loaders.delete('nodeModules')

//
module.exports = environment