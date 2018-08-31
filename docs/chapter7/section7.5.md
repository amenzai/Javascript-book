# 字典和散列表

集合、字典和散列表可以存储不重复的值。在集合中，我们感兴趣的是每个值本身，并把它当作主要元素。在字典中，我们用[键，值]的形式来存储数据。在散列表中也是一样（也是以[键，值]对的形式来存储数据）。

## 字典

**代码示例**

```js
function Dictionary() {
   this.add = add;
   this.datastore = new Array();
   this.find = find;
   this.remove = remove;
   this.showAll = showAll;
   this.count = count;
   this.clear = clear;
}

function add(key, value) {
   this.datastore[key] = value;
}

function find(key) {
   return this.datastore[key];
}

function remove(key) {
   delete this.datastore[key];
}

function showAll() {
   for each (var key in Object.keys(this.datastore).sort()) {
      print(key + " -> " + this.datastore[key]);
   }
}

function count() {
   var n = 0;
   for each (var key in Object.keys(this.datastore)) {
      ++n;
   }
   return n;
}

function clear() {
   for each (var key in Object.keys(this.datastore)) {
      delete this.datastore[key];
   } 
}

```

## 散列表

**代码示例**

```js
function HashTable() {
   this.table = new Array(137);
   this.simpleHash = simpleHash;
   this.betterHash = betterHash;
   this.showDistro = showDistro;
   this.put = put;
   this.get = get;
}

/*function put(data) {
   var pos = this.simpleHash(data);
   this.table[pos] = data;
}*/


// put for linear probing
function put(key, data) {
   var pos = this.betterHash(key);
   if (this.table[pos] == undefined) {
      this.table[pos] = key;
      this.values[pos] = data;
   }
   else {
      while (this.table[pos] != undefined) {
         pos++;
      }
      this.table[pos] = key;
      this.values[pos] = data;
   }
}

// put for separate chaining
function put(key, data) {
   var pos = this.betterHash(key);
   var index = 0;
   if (this.table[pos][index] == undefined) {
      this.table[pos][index] = data;
   }
   ++index;
   else {
      while (this.table[pos][index] != undefined) {
         ++index;
      }
      this.table[pos][index] = data;
   }
}
   
function simpleHash(data) {
   var total = 0;
   for (var i = 0; i < data.length; ++i) {
      total += data.charCodeAt(i);
   }
   print("Hash value: " + data + " -> " + total);
   return total % this.table.length;
}

function betterHash(string) {
   const H = 37;
   var total = 0;
   for (var i = 0; i < string.length; ++i) {
      total += H * total + string.charCodeAt(i);
   }
   total = total % this.table.length;
   if (total < 0) {
      total += this.table.length-1;
   }
   return parseInt(total);
}

function showDistro() {
   var n = 0;
   for (var i = 0; i < this.table.length; ++i) {
      if (this.table[i] != undefined) {
         print(i + ": " + this.table[i]);
      }
   }
}

function getRandomInt (min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function genStuData(arr) {
   for (var i = 0; i < arr.length; ++i) {
      var num = "";
      for (var j = 1; j <= 9; ++j) {
         num += Math.floor(Math.random() * 10);
      }
      num += getRandomInt(50,100);
      arr[i] = num;
   }
}

function buildChains(arr) {
   for (var i = 0; i < arr.length; ++i) {
      arr[i] = new Array();
   }
}

function inHash(key, arr) {
   var hash = simpleHash(key, arr);
   var n = 0;
   if (key == arr[hash][n]) {
      return true;
   }
   else {
      while (arr[hash][n] != undefined) {
         if (arr[hash][n] == key) {
            return true;
         }
         ++n;
      }
   }
   return false;
}

// get for separate chaining
function get(key) {
   var index = 0;
   var hash = this.betterHash(key);
   if (this.table[pos][index] = key) {
      return this.table[pos][index+1];
   }
   index += 2;
   else {
      while (this.table[pos][index] != key) {
         index += 2;
      }
      return this.table[pos][index+1];
   }
   return undefined;
}

// get for linear probing
function get(key) {
   var hash = -1;
   hash = this.betterHash(key);
   if (hash > -1) {
      for (var i = hash; this.table[hash] != undefined; i++) {
         if (this.table[hash] == key) {
            return this.values[hash];
         }
      }
   }
   return undefined;
}

function get(key) {
   return this.table[this.betterHash(key)];
}

```