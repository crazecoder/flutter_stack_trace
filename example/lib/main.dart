import 'package:flutter/material.dart';
import 'package:flutter_stack_trace/flutter_stack_trace.dart';

void main() => FlutterChain.capture(
      () {
        runApp(MyApp());
      },
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterChain.print("123");
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _click,
        child: Icon(Icons.add),
      ),
    );
  }

  _click() {
    FlutterChain.print("test", isShowTime: false);
    _scheduleAsync();
  }

  void _scheduleAsync() {
    new Future.delayed(new Duration(seconds: 1)).then((_) => _runAsync());
  }

  void _runAsync() {
    throw 'oh no!';
  }
}
