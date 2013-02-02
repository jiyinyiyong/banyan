
require = do ->

  String.prototype.__defineGetter__ 'end', ->
    end = @length - 1
    @[end]

  Array.prototype.__defineGetter__ 'end', ->
    end = @length - 1
    @[end]

  NodeList.prototype.__defineGetter__ 'end', ->
    end = @length - 1
    @[end]

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

  require = (name) ->
    console.log require.stack
    path = require.stack.end
    unless url$ name
      path = join path, name
    if require.stack.length > 10 then return
    console.log require.cache[path]
    if require.cache[path]?
      require.cache[path]
    else
      path_str = JSON.stringify path
      # console.log path_str
      req = new XMLHttpRequest
      req.open 'get', path, no
      req.send()
      require.cache[path] = {}
      code = "(function(){\n" +
        'var module = {' +
        "path: #{path_str}};\n" +
        "require.stack.push(#{path_str});" +
        "var exports = {};\n" +
        req.responseText +
        'require.stack.pop();\n' +
        "\nreturn exports;\n})()"
      require.cache[path] = eval code

  require.cache = {}
  require.stack = [curr_src]

  require