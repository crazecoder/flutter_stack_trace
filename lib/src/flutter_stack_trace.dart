import 'dart:isolate';
import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';

class FlutterChain {
  FlutterChain._();

  static void capture<T>(
    T callback(), {
    void onError(error, Chain chain)?,
    bool simple = true,
  }) {
    Isolate.current.addErrorListener(RawReceivePort((dynamic pair) async {
      var isolateError = pair as List<dynamic>;
      var _error = isolateError.first;
      var _stackTrace = isolateError.last;
      Zone.current.handleUncaughtError(_error, _stackTrace);
    }).sendPort);
    runZonedGuarded(
      () {
        FlutterError.onError = (FlutterErrorDetails details) async {
          Zone.current.handleUncaughtError(details.exception, details.stack!);
        };
        callback();
      },
      (_error, _stack) {
        printError(_error, _stack, simple: simple);
      },
    );
    FlutterError.onError = (FlutterErrorDetails details) async {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    };
  }

  static printError(_error, _stack, {bool simple: true}) {
    debugLog(_error.toString(),
        isShowTime: false, showLine: true, isDescription: true);
    String errorStr = "";
    if (simple) {
      errorStr = _parseFlutterStack(Trace.from(_stack));
    } else {
      errorStr = Trace.from(_stack).toString();
    }
    if (errorStr.isNotEmpty)
      debugLog(errorStr,
          isShowTime: false, showLine: true, isDescription: false);
  }

  static String _parseFlutterStack(Trace _trace) {
    String result = "";
    String _traceStr = _trace.toString();
    List<String> _strs = _traceStr.split("\n");
    _strs.forEach((_str) {
      if (!_str.contains("package:flutter/") &&
          !_str.contains("dart:") &&
          !_str.contains("package:flutter_stack_trace/")) {
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
}

///
/// print message when debug.
///
/// `maxLength` takes effect when `isDescription = true`, You can edit it based on your console width
///
/// `isDescription` means you're about to print a long text
///
/// debugLog(
///   "1234567890",
///   isDescription: true,
///   maxLength: 1,
/// );
///  ------
///  | 1  |
///  | 2  |
///  | 3  |
///  | 4  |
///  | 5  |
///  | 6  |
///  | 7  |
///  | 8  |
///  | 9  |
///  | 0  |
///  ------
///

void debugLog(dynamic obj,
    {bool isShowTime = false,
    bool? showLine = null,
    int maxLength = 100,
    bool isDescription = true}) {
  bool isDebug = false;
  assert(isDebug = true);

  if (isDebug) {
    String slice = obj.toString();
    if (isDescription) {
      if (obj.toString().length > maxLength) {
        if (showLine == null) {
          showLine = false;
        } else {
          showLine = true;
        }
        List<String> objSlice = [];
        for (int i = 0;
            i <
                (obj.toString().length % maxLength == 0
                    ? obj.toString().length / maxLength
                    : obj.toString().length / maxLength + 1);
            i++) {
          if (maxLength * i > obj.toString().length) {
            break;
          }
          objSlice.add(obj.toString().substring(
              maxLength * i,
              maxLength * (i + 1) > obj.toString().length
                  ? obj.toString().length
                  : maxLength * (i + 1)));
        }
        slice = "\n";
        objSlice.forEach((element) {
          slice += "$element\n";
        });
      }
    }
    _print(slice, showLine: showLine ?? true, isShowTime: isShowTime);
  }
}

_debugPrint(dynamic msg, {String? tag}) {
  const bool inProduction = bool.fromEnvironment("dart.vm.product");
  if (!inProduction) {
    log(msg ?? "null", name: tag ?? 'flutter log');
  }
}

_print(String content, {bool isShowTime = true, bool showLine = false}) {
  String log = isShowTime ? "${DateTime.now()}:  $content" : "$content";
  if (showLine) {
    var logSlice = log.split("\n");
    int maxLength = _getMaxLength(logSlice) + 3;
    String line = "-";
    for (int i = 0; i < maxLength + 1; i++) {
      line = "$line-";
    }
    _debugPrint(line);
    logSlice.forEach((_log) {
      if (_log.isEmpty) {
        return;
      }
      int gapLength = maxLength - _log.length;
      if (gapLength > 0) {
        String space = " ";
        for (int i = 0; i < gapLength - 3; i++) {
          space = "$space ";
        }
        _debugPrint("| $_log$space |");
      }
    });
    _debugPrint(line);
  } else {
    _debugPrint(log);
  }
}

int _getMaxLength(List<String> logSlice) {
  List<int> lengthList = <int>[];
  logSlice.forEach((_log) {
    lengthList.add(_log.length);
  });
  lengthList.sort((left, right) => right - left);
  return lengthList[0];
}
