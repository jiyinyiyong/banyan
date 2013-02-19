
# Banyan is a testing loader for browser-side JavaScript

### Goal

It's cool to modularize client-side JS like writing Node app.  
And why do people write `define` or use AMD syntax?  
If that's for speed, it worth writing that.  
But when speed is not that important, why create one more indetation?  

When using Banyan, first including the `require.js` file.  
Read the code in [page/][page] directory as a demo.  

[page]: https://github.com/jiyinyiyong/banyan/tree/gh-pages/page

Here's the code for HTML:  

```html
<script src="require.js" entry="main.js" defer></script>
```

Banyan only works in Chrome for I modified `prototype`.  
The code is not rubost. Only `js` and `json` files can be recoginized.  
Files with other extension name are only texts.  

### Thanks

Based on this example:  
http://webreflection.blogspot.de/2010/02/commonjs-why-server-side-only.html  

Demo of `@ sourceURL`:  
http://www.thecssninja.com/demo/source_mapping/compile.html  