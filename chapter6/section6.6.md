# Web Worker

JavaScript语言采用的是单线程模型，也就是说，所有任务排成一个队列，一次只能做一件事。随着电脑计算能力的增强，这一点带来很大的不便，无法充分发挥JavaScript的潜力。尤其考虑到，File API允许JavaScript读取本地文件，就更是如此了。

Web Worker的目的，就是为JavaScript创造多线程环境，允许主线程将一些任务分配给子线程。在主线程运行的同时，子线程在后台运行，两者互不干扰。等到子线程完成计算任务，再把结果返回给主线程。因此，每一个子线程就好像一个“工人”（worker），默默地完成自己的工作。

普通的Wek Worker，只能与创造它们的主进程通信。还有另一类Shared worker，能被所有同源的进程获取（比如来自不同的浏览器窗口、iframe窗口和其他Shared worker）。

Web Worker有以下几个特点：

- 同域限制。子线程加载的脚本文件，必须与主线程的脚本文件在同一个域。
DOM限制。子线程无法读取网页的DOM对象，即document、window、parent这些对象，子线程都无法得到。（但是，navigator对象和location对象可以获得。）
- 脚本限制。子线程无法读取网页的全局变量和函数，也不能执行alert和confirm方法，不过可以执行setInterval和setTimeout，以及使用XMLHttpRequest对象发出AJAX请求。
- 文件限制。子线程无法读取本地文件，即子线程无法打开本机的文件系统（file://），它所加载的脚本，必须来自网络。

检查支持情况

```js
if (window.Worker) {
  // 支持
} else {
  // 不支持
}
```

使用：

```js
// 主进程文件
var worker = new Worker('http://127.0.0.1:9292/work.js');
  // 发送的数据可以是字符串或者对象
  // worker.postMessage("Hello World");
  worker.postMessage({method: 'echo', args: ['Work']});

  worker.addEventListener('message', function(e) {
      console.log(e.data);
  }, false);

// work.js
self.addEventListener('message', function(e) {
  console.log(e.data.method)
  // 可以进行一些操作在对主进程进行发送信息   
  self.postMessage('You said: ' + e.data.method);
}, false);