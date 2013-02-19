
require = do ->

  String.prototype.__defineGetter__ 'end', -> @[@length - 1]
  Array.prototype.__defineGetter__ 'end', -> @[@length - 1]
  NodeList.prototype.__defineGetter__ 'end', -> @[@length - 1]

  url$ = (path) -> path.match(/^https?:\/\/\S+$/)?

  src_elems = document.getElementsByTagName 'script'
  curr_src = src_elems.end.src

  get_base = (path) ->
    if path.length is 0 then ""
    while path.end is "/"
      path = path[...-1]
    until path.end is "/"
      path = path[...-1]
    path

  join = (base, path) ->
    if path[0] is "/"
      path
    else
      unless base.end is '/' then base += "/"
      while path[0] is '.'
        if path[..1] is './'
          path = path[2..]
        else if path[..2] is '../'
          path = path[3..]
          if base.length > 0
            base = base[...-1]
            until base.end is '/'
              base = base[...-1]
          else
            throw new Error "Can not solve #{base}/#{path}"
            
    path = path
      .replace(/\/\.\//g, "/")
      .replace(/\/[^\/]+\/\.\.\//, "/")

    (get_base base) + path

  get_ext = (path) ->
    extname = ''
    while path.end? and (path.end isnt '.')
      extname = path.end + extname
      path = path[...-1]
    extname

  require = (name) ->
    # console.log require.stack
    path = require.stack.end
    unless url$ name
      path = join path, name
    # if require.stack.length > 10 then return
    # console.log require.cache[path]
    if require.cache[path]?
      require.cache[path]
    else
      path_str = JSON.stringify path
      # console.log path_str
      req = new XMLHttpRequest
      req.open 'get', path, no
      req.send()
      # console.log (get_ext path)
      if (get_ext path) is 'js'
        require.cache[path] = {}
        code = "(function(){\n" +
          "var module = {path: #{path_str}};\n" +
          "require.stack.push(module.path);\n" +
          "var exports = {};\n" +
          req.responseText + '\n' +
          'require.stack.pop();\n' +
          "return exports;\n})()\n" +
          "//@ sourceURL=#{name}"
        require.cache[path] = eval code
      else if get_ext path is 'json'
        require.cache[path] = JSON.parse "(#{req.responseText})"
      else
        require.cache[path] = req.responseText

  require.cache = {}
  require.stack = [curr_src]

  require

do ->
  script = document.getElementsByTagName("script").end
  entry = script.getAttribute("entry")
  require entry