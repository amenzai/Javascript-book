# Web Storage

## localStorage&sessionStorage

```js
// 存入
sessionStorage.setItem("key","value");
localStorage.setItem("key","value");

// 读取
var valueSession = sessionStorage.getItem("key");
var valueLocal = localStorage.getItem("key");

// 清除
sessionStorage.removeItem('key');
localStorage.removeItem('key');

// 所有
sessionStorage.clear();
localStorage.clear(); 

// 遍历所有的键
for(var i = 0; i < localStorage.length; i++){
    console.log(localStorage.key(i));
}

// 当储存的数据发生变化时，会触发storage事件。
window.addEventListener("storage",onStorageChange);
function onStorageChange(e) {
     // 保存发生变化的键名
     console.log(e.key);    
// 其他属性
// oldValue：更新前的值。如果该键为新增加，则这个属性为null。
// newValue：更新后的值。如果该键被删除，则这个属性为null。
// url：原始触发storage事件的那个网页的网址。
}

> 值得特别注意的是，该事件不在导致数据变化的当前页面触发。如果浏览器同时打开一个域名下面的多个页面，当其中的一个页面改变sessionStorage或localStorage的数据时，其他所有页面的storage事件会被触发，而原始页面并不触发storage事件。可以通过这种机制，实现多个窗口之间的通信。所有浏览器之中，只有IE浏览器除外，它会在所有页面触发storage事件。
```

[参考文章](http://javascript.ruanyifeng.com/bom/webstorage.html)