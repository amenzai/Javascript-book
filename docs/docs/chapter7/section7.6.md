# 树

到目前为止，本书介绍了一些顺序数据结构，介绍的第一个非顺序数据结构是散列表。在本章，我们将要学习另一种非顺序数据结构——树，它对于存储需要快速查找的数据非常有用。

树是一种分层数据的抽象模型。现实生活中最常见的树的例子是家谱，或是公司的组织架构

## 二叉搜索树

二叉树中的节点最多只能有两个子节点：一个是左侧子节点，另一个是右侧子节点。这些定义有助于我们写出更高效的向/从树中插入、查找和删除节点的算法。二叉树在计算机科学中的应用非常广泛。

二叉搜索树（BST）是二叉树的一种，但是它只允许你在左侧节点存储（比父节点）小的值，在右侧节点存储（比父节点）大（或者等于）的值。上一节的图中就展现了一棵二叉搜树。

**代码示例**

```js
function Node(data, left, right) {
   this.data = data;
   this.left = left;
   this.right = right;
   this.show = show;
}

function show() {
   return this.data;
}

function BST() {
   this.root = null;
   this.insert = insert;
   this.inOrder = inOrder;
   this.preOrder = preOrder;
   this.postOrder = postOrder;
   this.getmin = getmin;
   this.getmax = getmax;
   this.find = find;
   this.remove = remove;
   this.removeNode = removeNode;
   this.getSmallest = getSmallest;
}

function insert(data) {
   var n = new Node(data, null, null);
   if (this.root == null) {
      this.root = n;
   }
   else {
      var current = this.root;
      var parent;
      while (true) {
         parent = current;
         if (data < current.data) {
            current = current.left;
            if (current == null) {
               parent.left = n;
               break;
            }
         }
         else {
            current = current.right;
            if (current == null) {
               parent.right = n;
               break;
            }
         }
      }
   }
}

function inOrder(node) {
   if (!(node == null)) {
      inOrder(node.left);
      putstr(node.show() + " ");
      inOrder(node.right);
   }
}

function preOrder(node) {
   if (!(node == null)) {
      putstr(node.show() + " ");
      preOrder(node.left);
      preOrder(node.right);
   }
}

function postOrder(node) {
   if (!(node == null)) {
      postOrder(node.left);
      postOrder(node.right);
      putstr(node.show() + " ");
   }
}

function getmin() {
   var current = this.root;
   print("debug: " + current.data);
   while (!(current.left == null)) {
      current = current.left;
   }
   return current.data;
}

function getmax() {
   var current = this.root;
   while (!(current.right == null)) {
      current = current.right;
   }
   return current.data;
}

function find(data) {
   var current = this.root;
   while (current.data != data) {
      if (data < current.data) {
         current = current.left;
      }
      else {
         current = current.right;
      }
      if (current == null) {
         return null;
      }
   }
   return current;
}

function getSmallest(node) {
   if (node.left == null) {
      return node;
   }
   else {
      return getSmallest(node.left);
   }
}

function remove(data) {
   root = removeNode(this.root, data);
}

function removeNode(node, data) {
   if (node == null) {
      return null;
   }
   if (data == node.data) {
      // node has no children
      if (node.left == null && node.right == null) {
         return null;
      }
      // node has no left child
      if (node.left == null) {
         return node.right;
      }
      // node has no right child
      if (node.right == null) {
         return node.left;
      }
      // node has two children
      var tempNode = getSmallest(node.right);
      node.data = tempNode.data;
      node.right = removeNode(node.right, tempNode.data);
      return node;
   }
   else if (data < node.data) {
      node.left = removeNode(node.left, data);
      return node;
   }
   else {
      node.right = removeNode(node.right, data);
      return node;
   }
}
      
   

var nums = new BST();
nums.insert(23);
nums.insert(45);
nums.insert(16);
nums.insert(37);
nums.insert(3);
nums.insert(99);
nums.insert(22);
/*print("Inorder traversal: ");
inOrder(nums.root);
print("\n");
print("Preorder traversal: ");
preOrder(nums.root);
print("\n");
print("Postorder traversal: ");
postOrder(nums.root);
print("\n");
var min = nums.getmin();
print("The minimum value of the BST is: " + min);
var max = nums.getmax();
print("The maximum value of the BST is: " + max);
inOrder(nums.root);
print("\n");
putstr("Enter a value to search for: ");
var value = parseInt(readline());
var found = nums.find(value);
if (found != null) {
   print("Found " + value + " in the BST.");
}
else {
   print(value + " was not found in the BST.");
}*/
inOrder(nums.root);
print("\n");
var num = parseInt(readline());
nums.remove(num);
inOrder(nums.root);
```