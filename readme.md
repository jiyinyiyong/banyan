
# Banyan is a loader for browser-side JavaScript

### Goal

It's cool to modularize client-side JS like writing Node app.  
And why do people write `define` or use AMD syntax?  
If that's for speed, it worth writing that.  
But when speed is not that important, why create one more indetation?  

When using Banyan, first including the `require.js` file.  
Then use `<script>` tag to include one more source file.  
Other files can be simply required from code.  
Read the code in [page/][page] directory as a demo.  

[page]: https://github.com/jiyinyiyong/banyan/tree/gh-pages/page

Live demo: http://jiyinyiyong.github.com/banyan/page/  
Banyan only works in Chrome for I'm rewriting `prototype`.  
The code is not rubost. `js` and `json` files can be recoginized.  
Files with other extension name are only texts.  

### Todo

* It's not friendly enough to CoffeeScript.  

* Banyan lack consideration of `window.onload` event.  
  So you'd better put `<script>` and the end of page.  

### Reference

Based on this example:  
http://webreflection.blogspot.de/2010/02/commonjs-why-server-side-only.html  