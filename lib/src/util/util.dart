/// util or helper functions for some operations
bool _isList(list) => list is List;

/// util or helper functions for some operations
List _add(r1, r2) {
  List temList = [];
  for (int i = 0; i < r1.length; i++) {
    var val = r1[i] + r2[i];
    temList.add(val);
  }
  return temList;
}

/// util or helper functions for some operations
utladdition(List l1, List l2) {
  List res = [];
  for (int i = 0; i < l1.length; i++) {
    if (_isList(l1[i])) {
      res.add(_add(l1[i], l2[i]));
    } else {
      var val = l1[i] + l2[i];
      res.add(val);
    }
  }
  return res;
}

/// util or helper functions for some operations
List _sub(r1, r2) {
  List temList = [];
  for (int i = 0; i < r1.length; i++) {
    var val = r1[i] - r2[i];
    temList.add(val);
  }
  return temList;
}

/// util or helper functions for some operations
utlsubtraction(List l1, List l2) {
  List res = [];
  for (int i = 0; i < l1.length; i++) {
    if (_isList(l1[i])) {
      res.add(_sub(l1[i], l2[i]));
    } else {
      var val = l1[i] - l2[i];
      res.add(val);
    }
  }
  return res;
}

/// util or helper functions for some operations
List _div(r1, r2) {
  List temList = [];
  for (int i = 0; i < r1.length; i++) {
    double val = r1[i] / r2[i];
    temList.add(val);
  }
  return temList;
}

/// util or helper functions for some operations
utldivition(List l1, List l2) {
  List res = [];
  for (int i = 0; i < l1.length; i++) {
    if (_isList(l1[i])) {
      res.add(_div(l1[i], l2[i]));
    } else {
      var val = l1[i] / l2[i];
      res.add(val);
    }
  }
  return res;
}

/// util array sum
num utlArrSum(List numbers) => numbers.reduce((a, b) => a + b);

/// util array min
num utlArrMin(List numbers) {
  numbers.sort();
  return numbers[0];
}

/// util array max
num arrMax(List numbers) {
  numbers.sort();
  return numbers[numbers.length - 1];
}
