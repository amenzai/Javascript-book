# RegExp对象

## 原型对象的属性和方法

### 属性

- ignoreCase：返回一个布尔值，表示是否设置了i修饰符，该属性只读。
- global：返回一个布尔值，表示是否设置了g修饰符，该属性只读。
- multiline：返回一个布尔值，表示是否设置了m修饰符，该属性只读。

```js
var r = /abc/igm;

r.ignoreCase // true
r.global // true
r.multiline // true
```
- lastIndex：返回下一次开始搜索的位置。该属性可读写，但是只在设置了g修饰符时有意义。
- source：返回正则表达式的字符串形式（不包括反斜杠），该属性只读。

```js
var r = /abc/igm;

r.lastIndex // 0
r.source // "abc"
```

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

## 元字符

（1）点字符（.)

点字符（.）匹配除回车（\r）、换行(\n) 、行分隔符（\u2028）和段分隔符（\u2029）以外的所有字符。注意，对于码点大于0xFFFF字符，点字符不能正确匹配，会认为这是两个字符。
```js
/c.t/
```
上面代码中，c.t匹配c和t之间包含任意一个字符的情况，只要这三个字符在同一行，比如cat、c2t、c-t等等，但是不匹配coot。

（2）位置字符

位置字符用来提示字符所处的位置，主要有两个字符。

- ^ 表示字符串的开始位置
- $ 表示字符串的结束位置

```js
// test必须出现在开始位置
/^test/.test('test123') // true

// test必须出现在结束位置
/test$/.test('new test') // true

// 从开始位置到结束位置只有test
/^test$/.test('test') // true
/^test$/.test('test test') // false
```

（3）选择符（|）

竖线符号（|）在正则表达式中表示“或关系”（OR），即cat|dog表示匹配cat或dog。

```js
/11|22/.test('911') // true
```

上面代码中，正则表达式指定必须匹配11或22。

多个选择符可以联合使用。

```js
// 匹配fred、barney、betty之中的一个
/fred|barney|betty/
```

选择符会包括它前后的多个字符，比如/ab|cd/指的是匹配ab或者cd，而不是指匹配b或者c。如果想修改这个行为，可以使用圆括号。

```js
/a( |\t)b/.test('a\tb') // true
```
上面代码指的是，a和b之间有一个空格或者一个制表符。

其他的元字符还包括\、\*、+、?、()、[]、{}等，将在下文解释。

[参考文章](http://javascript.ruanyifeng.com/stdlib/regexp.html)

