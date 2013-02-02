
exports.say = ->
  console.log "lib loaded"

data = require 'nest/nested-lib.js'

console.log data

console.log (require '../readme.md')