# 概述

## 对象是什么

**对象是单个实物的抽象**
一本书、一辆汽车、一个人都可以是对象，一个数据库、一张网页、一个与远程服务器的连接也可以是对象。当实物被抽象成对象，实物之间的关系就变成了对象之间的关系，从而就可以模拟现实情况，针对对象进行编程。

**对象是一个容器，封装了属性（property）和方法（method）**
属性是对象的状态，方法是对象的行为（完成某种任务）。比如，我们可以把动物抽象为animal对象，使用“属性”记录具体是那一种动物，使用“方法”表示动物的某种行为（奔跑、捕猎、休息等等）。

## 构造函数
JavaScript 语言使用构造函数（constructor）作为对象的模板。所谓”构造函数”，就是专门用来生成对象的函数。它提供模板，描述对象的基本结构。一个构造函数，可以生成多个对象，这些对象都有相同的结构。

```js
var Vehicle = function () {
  this.price = 1000;
};
```

要点：

- 函数体内部使用了this关键字，代表了所要生成的对象实例。
- 生成对象的时候，必需用new命令，调用Vehicle函数。

## new 命令

### 基本用法
new命令的作用，就是执行构造函数，返回一个实例对象。

一个很自然的问题是，如果忘了使用new命令，直接调用构造函数会发生什么事？

这种情况下，构造函数就变成了普通函数，并不会生成实例对象。而且由于后面会说到的原因，this这时代表全局对象，将造成一些意想不到的结果。

解决方案：

```js
function Fubar(foo, bar){
  'use strict'; // 严格模式会报错
  this._foo = foo;
  this._bar = bar;
}

Fubar()
// TypeError: Cannot set property '_foo' of undefined

// another
function Fubar(foo, bar) {
  if (!(this instanceof Fubar)) {
    return new Fubar(foo, bar);
  }

  this._foo = foo;
  this._bar = bar;
}

Fubar(1, 2)._foo // 1
(new Fubar(1, 2))._foo // 1
```

### new 命令的原理 
使用new命令时，它后面的函数依次执行下面的步骤。

- 创建一个空对象，作为将要返回的对象实例。
- 将这个空对象的原型，指向构造函数的prototype属性。
- 将这个空对象赋值给函数内部的this关键字。
- 开始执行构造函数内部的代码。

也就是说，构造函数内部，this指的是一个新生成的空对象，所有针对this的操作，都会发生在这个空对象上。构造函数之所以叫“构造函数”，就是说这个函数的目的，就是操作一个空对象（即this对象），将其“构造”为需要的样子。

如果构造函数内部有return语句，`而且return后面跟着一个对象`，new命令会返回return语句指定的对象；否则，就会不管return语句，返回this对象。

### new.target

函数内部可以使用new.target属性。如果当前函数是new命令调用，new.target指向当前函数，否则为undefined。

```js
function f() {
  console.log(new.target === f);
}

f() // false
new f() // true
```

## 使用 Object.create() 创建实例对象
构造函数作为模板，可以生成实例对象。但是，有时只能拿到实例对象，而该对象根本就不是由构造函数生成的，这时可以使用Object.create()方法，直接以某个实例对象作为模板，生成一个新的实例对象。

```js
var person1 = {
  name: '张三',
  age: 38,
  greeting: function() {
    console.log('Hi! I\'m ' + this.name + '.');
  }
};

var person2 = Object.create(person1);

person2.name // 张三
person2.greeting() // Hi! I'm 张三.
```