# RegExp对象

## 原型对象的属性和方法

### 属性

- ignoreCase：返回一个布尔值，表示是否设置了i修饰符，该属性只读。
- global：返回一个布尔值，表示是否设置了g修饰符，该属性只读。
- multiline：返回一个布尔值，表示是否设置了m修饰符，该属性只读。
- lastIndex：返回下一次开始搜索的位置。该属性可读写，但是只在设置了g修饰符时有意义。
- source：返回正则表达式的字符串形式（不包括反斜杠），该属性只读。

### test()

test方法返回一个布尔值，表示当前模式是否能匹配参数字符串

```js
var r = /x/g;
var s = '_x_x';

r.lastIndex // 0
r.test(s) // true

r.lastIndex // 2
r.test(s) // true

r.lastIndex // 4
r.test(s) // false
```

### exec()
返回匹配结果。如果发现匹配，就返回一个数组，成员是每一个匹配成功的子字符串，否则返回null。
```js
var s = '_x_x';
var r1 = /x/;
var r2 = /y/;

r1.exec(s) // ["x"]
r2.exec(s) // null
```
[参考文章](http://javascript.ruanyifeng.com/stdlib/regexp.html)

