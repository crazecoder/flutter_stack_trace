import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';
import 'dart:async';

class FlutterChain {
  FlutterChain._();

  static void capture<T>(
    T callback(), {
    void onError(error, Chain chain),
    bool debug = true,
    bool simple = true,
  }) {
    runZoned(
      () {
        FlutterError.onError = (FlutterErrorDetails details) async {
          Zone.current.handleUncaughtError(details.exception, details.stack);
        };
        callback();
      },
      onError: (_error, _stack) {
        if (debug) {
          debugPrint(_error.toString());
          String errorStr = "";
          if (simple) {
            errorStr = _parseFlutterStack(Trace.from(_stack));
          } else {
            errorStr = Trace.from(_stack).toString();
          }
          if (errorStr.isNotEmpty) debugPrint(errorStr);
        }
      },
    );
  }

  static String _parseFlutterStack(Trace _trace) {
    String result = "";
    String _traceStr = _trace.toString();
    List<String> _strs = _traceStr.split("\n");
    _strs.forEach((_str) {
      if (!_str.contains("package:flutter/src/") && !_str.contains("dart:")) {
        if (_str.isNotEmpty) {
          if (result.isNotEmpty)
            result = "$result\n$_str";
          else
            result = _str;
        }
      }
    });
    return result;
  }

  static void print(Object obj, {bool isShowTime = true}) {
    if (isInDebugMode) {
      debugPrint(isShowTime ? "${DateTime.now()}:  ${obj.toString()}" : "${obj
          .toString()}");
    }
  }
}

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}
