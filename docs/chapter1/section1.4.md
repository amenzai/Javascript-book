# 字符串

是个特殊的数组
```js
var str = 'hello'
str[0] // h
```

想要使用数组方法需要借助call方法。
```js
var s = 'hello';

s.join(' ') // TypeError: s.join is not a function

Array.prototype.join.call(s, ' ') // "h e l l o"
```

\n  反斜杠转义

base64编码：
- btoa()编码  
- atob()解码

中文在进行base编码时，先用encodeURIComponent()进行编码，解码一样。

