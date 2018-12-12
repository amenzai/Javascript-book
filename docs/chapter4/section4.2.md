# Element对象

## 特征相关的属性

### Element.attributes

### Element.id，Element.tagName

### Element.innerHTML

### Element.outerHTML

### Element.className，Element.classList

classList对象有下列方法。

- add()：增加一个class。
- remove()：移除一个class。
- contains()：检查当前元素是否包含某个class。
- toggle()：将某个class移入或移出当前元素。
- item()：返回指定索引位置的class。
- toString()：将class的列表转为字符串。

## 盒状模型相关属性
### Element.clientHeight，Element.clientWidth

### Element.scrollHeight，Element.scrollWidth

### Element.scrollLeft，Element.scrollTop

### Element.offsetHeight，Element.offsetWidth

### Element.offsetLeft，Element.offsetTop
Element.offsetLeft返回当前元素左上角相对于Element.offsetParent节点的水平位移，Element.offsetTop返回垂直位移，单位为像素。通常，这两个值是指相对于父节点的位移。

## 相关节点的属性
### Element.children

### Element.firstElementChild，Element.lastElementChild

### Element.nextElementSibling，Element.previousElementSibling

### Element.offsetParent
回当前 HTML 元素的最靠近的、并且 CSS 的position属性不等于static的上层元素。

## 属性相关的方法

- Element.getAttribute()：读取指定属性
- Element.setAttribute()：设置指定属性
- Element.hasAttribute()：返回一个布尔值，表示当前元素节点是否有指定的属性
- Element.removeAttribute()：移除指定属性

## 查找相关的方法

- Element.querySelector()
- Element.querySelectorAll()
- Element.getElementsByTagName()
- Element.getElementsByClassName()

## 事件相关的方法

Element.addEventListener()：添加事件的回调函数
Element.removeEventListener()：移除事件监听函数
Element.dispatchEvent()：触发事件

## 其他方法

### Element.remove()
将当前元素节点从DOM树删除。