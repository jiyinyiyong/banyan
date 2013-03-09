
require = do ->

  String.prototype.__defineGetter__ 'end', -> @[@length - 1]
  Array.prototype.__defineGetter__ 'end', -> @[@length - 1]
  NodeList.prototype.__defineGetter__ 'end', -> @[@length - 1]

  url$ = (path) -> path.match(/^https?:\/\/\S+$/)?

  curr_src = document.getElementsByTagName('script').end.src

  get_base = (path) ->
    if path.length is 0 then ""
    path = path[...-1] while path.end? and (path.end is "/")
    path = path[...-1] until (path.end is "/") or (not path.end)
    path

  join_path = (curr_path, name) ->
    base = get_base curr_path
    base = base[...-1] while base.end? and base.end is "/"
    name = name[1..] while name[0]? and name[0] is "/"
    "#{base}/#{name}"

  get_ext = (path) ->
    match = path.match /\.\w+$/
    if match? then match[0][1..] else  ""

  get = (url) ->
    req = new XMLHttpRequest
    req.open "get", url, no
    req.send()
    req.responseText

  func = (code, path_str, name) ->
    "(function(){\n" +
    "var module = {path: #{path_str}};\n" +
    "require.stack.push(module.path);\n" +
    "var exports = {};\n" +
    "#{code}\n" +
    "require.stack.pop();\n" +
    "return exports;\n})()\n" +
    "//@ sourceURL=#{name}"

  require = (name) ->
    base = require.stack.end
    path =
      if require.map[name]? then require.map[name]
      else unless url$ name then join_path base, name
      else name
    unless require.cache[path]?
      path_str = JSON.stringify path
      source = get path
      extname = get_ext path
      require.cache[path] = {} unless require.cache[path]
      require.cache[path] = 
        switch extname
          when "js" then eval (func source, path_str, name)
          when "json" then JSON.parse source
          else source
    require.cache[path]

  require.map = {}
  require.cache = {}
  require.stack = [curr_src]
  require.resolve = (name) -> join_path require.stack.end, name

  require

do ->
  script = document.getElementsByTagName("script").end
  entry = script.getAttribute("entry")
  require entry