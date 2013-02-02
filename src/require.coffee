
require = do ->

  String.prototype.__defineGetter__ 'end', ->
    end = @length - 1
    @[end]

  module_cache = {}

  url$ = (path) -> path.match(/^https?:\/\/\S$/)?

  src_elems = document.getElementsByTagName 'script'
  curr_src = src_elems[src_elems.length-1].src

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

  (name) ->
    path = join curr_src, name
    req = new XMLHttpRequest
    req.open 'get', path, no
    req.send()
    code = "(function(){\n"
    code+= "var exports = {};"
    code+= "#{req.responseText}"
    code+= "\nreturn exports;\n})()"
    require[path] = eval code