
exports.say = ->
  console.log "lib loaded"

data = require 'nest/nested-lib.js'

console.log data

readme = require '../readme.md'

page = document.querySelector "#page"
page.innerText = readme

css = require "./page.css"
style = document.createElement "style"
style.setAttribute "scoped", "scoped"
style.innerHTML = css
page.appendChild style