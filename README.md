<h1 align="center">Matrix 2D 🧮</h1>

Matrix 2D a lightweight dart library providing a subset of Python's numpy package. This package is written in pure dart 🔥.

<!-- *please check example/example.dart* for examples. -->

## Operations 😁

- ```addition(listA,listB)``` returns array of sums of corresponding elements of listA and listB of any dimensions.

- ```subtraction(listA,listB)``` returns array of differences of corresponding elements of listA and listB of any dimensions.

- ```division(listA,listB)``` divides listA by listB and returns new array

- ```dot(listA,listB)``` Function returns the dot product of two arrays. For 2-D vectors, it is the equivalent to matrix multiplication. For 1-D arrays, it is the inner product of the vectors. For N-dimensional arrays, it is a sum product over the last axis of a and the second-last axis of b.

- ```shape(list)``` returns dimensions of input array if the array is uniform or error otherwise.

- ```flatten(list)``` returns 1-D representation of any shape and any levels of nesting of list array.

- ```transpose(list)``` Reverse the axes of an array and returns the modified array

- ```arange(start, stop, steps)``` returns evenly spaced values within the half-open interval ```[start, stop)``` with optional steps argument.

- ```zeros(row,cols)``` Return a new array of given shape and type, with zeros

- ```ones(row,cols)``` Return a new array of given shape and type, with ones

- ```sum(list)``` Function returns the sum of array elements

- ```reshape(list)```Reshaping means changing the shape of an array.

- ```diagonal(list)``` To find a diagonal element from a given matrix and gives output as one dimensional matrix.
- ```fill(row,cols,object)``` Just like `zeros()` and `ones` this function will return a new array of given shape, with given object(anything btw strings too)

+ ```compareobject(list,operation,obj)``` compare values inside an array with given object and operations. function will return a  new boolen array

*As soon as possible, more features will be available.*

## Examples

<h2>shape</h2>

```
List list = [[1, 2],[1, 2]];
var shape = m2d.shape(list);
print(shape);
```
<b>ouput</b>:
```
[2,2]
```
<hr>

<h2>flatten</h2>

```
List list = [[1, 2],[1, 2]];
var flatten = m2d.flatten(list);
print(flatten);
```
<b>ouput</b>:
```
[1,2,1,2]
```
<hr>
<h2>transpose</h2>

```
List list = [[1, 2],[1, 2]];
var transpose = m2d.transpose(list);
print(transpose);
```
<b>ouput</b>:
```
[[1,1],[2,2]]
```
<hr>
<h2>addition</h2>

```
List list1 = [[1, 1],[1, 1]];
List list2 = [[2, 2],[2, 2]];
var addition = m2d.addition(list1,list2);
print(addition);
```
<b>ouput</b>:
```
[[3,3],[3,3]]
```
<hr>
<h2>subtraction</h2>

```
List list1 = [[1, 1],[1, 1]];
List list2 = [[2, 2],[2, 2]];
var subtraction = m2d.subtraction(list1,list2);
print(subtraction);
```
<b>ouput</b>:
```
[[-1,-1],[-1,-1]]
```
<hr>
<h2>division</h2>

```
List list1 = [[1, 1],[1, 1]];
List list2 = [[2, 2],[0, 2]];
var division = m2d.subtraction(division,list2);
print(division);
```
<b>ouput</b>:
```
[[0.5,Infinity],[0.5,0.5]]
```
<hr>
<h2>dot operation</h2>

```
List list1 = [[1,2],[3,4]];
List list2 = [[11,12],[13,14]];
var dot = m2d.dot(division,list2);
print(dot);
```
<b>ouput</b>:
```
[[37, 40], [85, 92]]
```
<hr>
<h2>arange</h2>

```
var arange = m2d.arange(8);
print(arange);
```
<b>ouput</b>:
```
[[0,1,2,3,4,5,6,7,8]]
```
<hr>

<h2>sum</h2>

```
var list = [[2,2],[2,2]];
var sum = m2d.sum(list);
print(sum);
```
<b>ouput</b>:
```
8
```
<hr>
<h2>reshape</h2>

```
var list = [[0, 1, 2, 3, 4, 5, 6, 7]];
var reshape = m2d.reshape(list,2,4);
print(reshape);
```
<b>ouput</b>:
```
[[0, 1, 2, 3], [4, 5, 6, 7]]
```
<hr>
<h2>linspace</h2>

```
var linspace = m2d.linspace(2, 3, 5);
print(linspace);
```
<b>ouput</b>:
```
[2.0, 2.25, 2.5, 2.75, 3.0]
```
<hr>
<h2>diagonal</h2>

```
var list = [[1,1,1],[2,2,2],[3,3,3]];
var diagonal = m2d.diagonal(list);
print(diagonal);
```
<b>ouput</b>:
```
[1,2,3]
```
<hr>
<h2>compareobject</h2>

```
var list = [[1,1,1],[2,2,2],[3,3,3]];
var compare = m2d.compare(list,'>',2);
print(compare);
```
<b>ouput</b>:
```
[[false, false, false], [false, false, false], [true, true, true]]
```
<hr>
<h2>zeros,ones and fill</h2>

```
var zeros = m2d.zeros(2,2);
print(zeros);

var ones = m2d.ones(2,2);
print(ones);

var anything = m2d.fill(2,2,'i love dart');
print(anything);
```
<b>ouput</b>:
```
[[0,0],[1,1]]

[[1,1],[1,1]]

[['i love dart','i love dart'],['i love dart','i love dart']]
```

<hr>

## Contribution 🤓

Happy 😍 to recieve or provide contributions related to this package.

## Features and bugs 🐛

Please file feature requests and bugs at the [issue tracker](https://github.com/BuckthornInc/matrix2d/issues).

## Contact

if you have any questions , feel free to wite us on

+ [Gmail](mailto:buckthorninc@gmail.com)

+ [Twitter](https://twitter.com/buckthorninc)