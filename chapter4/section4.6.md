# CSS操作

## style属性
操作 CSS 样式最简单的方法，就是使用网页元素节点的getAttribute方法、setAttribute方法和removeAttribute方法，直接读写或删除网页元素的style属性。

```js
div.setAttribute(
  'style',
  'background-color:red;' + 'border:1px solid black;'
);
```

或者这样

```js
var divStyle = document.querySelector('div').style;
divStyle.backgroundColor = 'red';
divStyle.border = '1px solid black';
divStyle.width = '100px';
divStyle.height = '100px';
divStyle.fontSize = '10em';
```

## cssText属性
```js
var divStyle = document.querySelector('div').style;

divStyle.cssText = 'background-color: red;'
  + 'border: 1px solid black;'
  + 'height: 100px;'
  + 'width: 100px;';
```

## window.getComputedStyle()
行内样式（inline style）具有最高的优先级，改变行内样式，通常会立即反映出来。但是，网页元素最终的样式是综合各种规则计算出来的。因此，如果想得到元素现有的样式，只读取行内样式是不够的，我们需要得到浏览器最终计算出来的那个样式规则。

window.getComputedStyle方法，就用来返回这个规则。它接受一个DOM节点对象作为参数，返回一个包含该节点最终样式信息的对象。所谓“最终样式信息”，指的是各种CSS规则叠加后的结果。

```js
var div = document.querySelector('div');
window.getComputedStyle(div).backgroundColor
```

## styleSheets对象
document对象的styleSheets属性，可以返回当前页面的所有StyleSheet对象（即所有样式表）。它是一个类似数组的对象。