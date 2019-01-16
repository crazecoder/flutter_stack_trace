import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_stack_trace/flutter_stack_trace.dart';

void main() {
  test('adds one to input values', () {
    FlutterChain.capture(() {
      scheduleAsync();
    });
  });
}
void scheduleAsync() {
  new Future.delayed(new Duration(seconds: 1))
      .then((_) => runAsync());
}

void runAsync() {
  throw 'oh no!';
}
