
console.log 'nested lib'

exports.data = "I'm nested"

require '../parent-dir.js'

console.log (require "./data.json")