<h1 align="center">Matrix 2d 🧮</h1>

Matrix 2d a lightweight dart library providing a subset of Python's numpy package. This package is written in pure dart 🔥.

*please check example/example.dart* for examples.

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

## Contribution 🤓

Happy 😍 to recieve or provide contributions related to this package.

## Features and bugs 🐛

Please file feature requests and bugs at the [issue tracker](https://github.com/BuckthornInc/matrix2d/issues).