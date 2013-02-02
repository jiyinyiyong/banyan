// Generated by CoffeeScript 1.4.0
var require;

require = (function() {
  var curr_src, get_base, get_ext, join, src_elems, url$;
  String.prototype.__defineGetter__('end', function() {
    return this[this.length - 1];
  });
  Array.prototype.__defineGetter__('end', function() {
    return this[this.length - 1];
  });
  NodeList.prototype.__defineGetter__('end', function() {
    return this[this.length - 1];
  });
  url$ = function(path) {
    return path.match(/^https?:\/\/\S+$/) != null;
  };
  src_elems = document.getElementsByTagName('script');
  curr_src = src_elems.end.src;
  get_base = function(path) {
    if (path.length === 0) {
      "";

    }
    while (path.end === "/") {
      path = path.slice(0, -1);
    }
    while (path.end !== "/") {
      path = path.slice(0, -1);
    }
    return path;
  };
  join = function(base, path) {
    if (path[0] === "/") {
      path;

    } else {
      if (base.end !== '/') {
        base += "/";
      }
      while (path[0] === '.') {
        if (path.slice(0, 2) === './') {
          path = path.slice(2);
        } else if (path.slice(0, 3) === '../') {
          path = path.slice(3);
          if (base.length > 0) {
            base = base.slice(0, -1);
            while (base.end !== '/') {
              base = base.slice(0, -1);
            }
          } else {
            throw new Error("Can not solve " + base + "/" + path);
          }
        }
      }
    }
    path = path.replace(/\/\.\//g, "/").replace(/\/[^\/]+\/\.\.\//, "/");
    return (get_base(base)) + path;
  };
  get_ext = function(path) {
    var extname;
    extname = '';
    while ((path.end != null) && (path.end !== '.')) {
      extname = path.end + extname;
      path = path.slice(0, -1);
    }
    return extname;
  };
  require = function(name) {
    var code, path, path_str, req;
    path = require.stack.end;
    if (!url$(name)) {
      path = join(path, name);
    }
    if (require.cache[path] != null) {
      return require.cache[path];
    } else {
      path_str = JSON.stringify(path);
      req = new XMLHttpRequest;
      req.open('get', path, false);
      req.send();
      if ((get_ext(path)) === 'js') {
        require.cache[path] = {};
        code = "(function(){\n" + 'var module = {' + ("path: " + path_str + "};\n") + ("require.stack.push(" + path_str + ");") + "var exports = {};\n" + req.responseText + '\n' + 'require.stack.pop();\n' + "return exports;\n})()";
        return require.cache[path] = eval(code);
      } else if (get_ext(path === 'json')) {
        return require.cache[path] = JSON.parse("(" + req.responseText + ")");
      } else {
        return require.cache[path] = req.responseText;
      }
    }
  };
  require.cache = {};
  require.stack = [curr_src];
  return require;
})();
