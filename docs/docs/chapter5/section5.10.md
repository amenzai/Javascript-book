# requestAnimationFrame

requestAnimationFrame是浏览器用于定时循环操作的一个接口，类似于setTimeout，主要用途是按帧对网页进行重绘。

requestAnimationFrame的优势，在于充分利用显示器的刷新机制，比较节省系统资源。

html:
```html
<div id="anim">Click here to start animation</div> 
```

css:

```css
#anim {
  position:absolute;
  left:0px;
  width:150px;
  height:150px;
  background: blue;
  font-size: larger;
  color: white;
  border-radius: 10px;
  padding: 1em;
}
```

js:
```js
// shim layer with setTimeout fallback
window.requestAnimFrame = (function(){
  return  window.requestAnimationFrame || 
          window.webkitRequestAnimationFrame || 
          window.mozRequestAnimationFrame || 
          window.oRequestAnimationFrame || 
          window.msRequestAnimationFrame || 
          function(/* function FrameRequestCallback */ callback, /* DOMElement Element */ element){
            window.setTimeout(callback, 1000 / 60);
          };
})();


var elem = document.getElementById("anim");
var startTime = undefined;
 
function render(time) {
 
  if (time === undefined)
    time = Date.now();
  if (startTime === undefined)
    startTime = time;
 
  elem.style.left = ((time - startTime)/10 % 500) + "px";
}
 
elem.onclick = function() {

    (function animloop(){
      render();
      requestAnimFrame(animloop, elem);
    })();
      
};
```