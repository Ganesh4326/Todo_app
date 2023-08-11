

import 'dart:io';

void main() {
  print('welcome to dart');

  stdout.write('hello');

  var name = stdin.readLineSync();

  print('welcome, $name');
}