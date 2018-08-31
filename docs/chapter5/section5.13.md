# ArrayBuffer 对象，Blob 对象 

## ArrayBuffer 对象
ArrayBuffer 对象表示一段二进制数据，用来模拟内存里面的数据。通过这个对象，JavaScript 可以读写二进制数据。

浏览器原生提供ArrayBuffer()构造函数，用来生成实例。它接受一个整数作为参数，表示这段二进制数据占用多少个字节。
```js
var buffer = new ArrayBuffer(8);
```
上面代码中，实例对象buffer占用8个字节。

ArrayBuffer 对象有实例属性length和byteLength，都表示当前实例占用的内存长度（单位字节）。
```js
var buffer = new ArrayBuffer(8);
buffer.length // 8
buffer.length // 8
```
ArrayBuffer 对象有实例方法slice()，用来复制一部分内存。它接受两个整数参数，分别表示复制的开始位置（从0开始）和结束位置（复制时不包括结束位置），如果省略第二个参数，则表示一直复制到结束。
```js
var buf1 = new ArrayBuffer(8);
var buf2 = buf1.slice(0);
```
上面代码表示复制原来的实例。

## Blob 对象
Blob 对象表示一个二进制文件的数据内容，比如一个图片文件的内容就可以通过 Blob 对象读写。它通常用来读写文件。

浏览器原生提供Blob()构造函数，用来生成实例对象。
```js
new Blob(array [, options])
```
Blob构造函数接受两个参数。第一个参数是数组，成员是字符串或二进制对象，表示新生成的Blob实例对象的内容；第二个参数是可选的，是一个配置对象，目前只有一个属性type，它的值是一个字符串，表示数据的 MIME 类型，默认是空字符串。
```js
var htmlFragment = ['<a id="a"><b id="b">hey!</b></a>'];
var myBlob = new Blob(htmlFragment, {type : 'text/html'});
```
上面代码中，实例对象myBlob包含的是字符串。生成实例的时候，数据类型指定为text/html。

下面是另一个例子，Blob 保存 JSON 数据。
```js
var obj = { hello: 'world' };
var blob = new Blob([ JSON.stringify(obj) ], {type : 'application/json'});
```
Blob具有两个实例属性size和type，分别返回数据的大小和类型。
```js
var htmlFragment = ['<a id="a"><b id="b">hey!</b></a>'];
var myBlob = new Blob(htmlFragment, {type : 'text/html'});

myBlob.size // 32
myBlob.type // "text/html"
```
Blob具有一个实例方法slice，用来拷贝原来的数据，返回的也是一个Blob实例。
```js
myBlob.slice(start，end, contentType)
slice方法有三个参数，都是可选的。它们依次是起始的字节位置（默认为0）、结束的字节位置（默认为size属性的值，该位置本身将不包含在拷贝的数据之中）、新实例的数据类型（默认为空字符串）。
```