# flutter_stack_trace

[![pub package](https://img.shields.io/pub/v/flutter_stack_trace.svg)](https://pub.dartlang.org/packages/flutter_stack_trace)

[stack_trace](https://github.com/dart-lang/stack_trace) for flutter

### Before

```
I/flutter ( 3068): PlatformException(error, Attempt to invoke virtual method 'java.lang.String java.lang.Object.toString()' on a null object reference, null)
I/flutter ( 3068): package:flutter/src/services/message_codecs.dart 551:7     StandardMethodCodec.decodeEnvelope
I/flutter ( 3068): package:flutter/src/services/platform_channel.dart 292:18  MethodChannel.invokeMethod
I/flutter ( 3068): dart:async/future_impl.dart 22:43                          _Completer.completeError
I/flutter ( 3068): dart:async/runtime/libasync_patch.dart 40:18               _AsyncAwaitCompleter.completeError
I/flutter ( 3068): package:flutter/src/services/platform_channel.dart         MethodChannel.invokeMethod
I/flutter ( 3068): dart:async/zone.dart 1053:19                               _CustomZone.registerUnaryCallback
I/flutter ( 3068): dart:async/runtime/libasync_patch.dart 77:23               _asyncThenWrapperHelper
I/flutter ( 3068): package:flutter/src/services/platform_channel.dart         MethodChannel.invokeMethod
I/flutter ( 3068): package:fluttertoast/fluttertoast.dart 53:33               Fluttertoast.showToast
```

### After

```
I/flutter ( 3068): PlatformException(error, Attempt to invoke virtual method 'java.lang.String java.lang.Object.toString()' on a null object reference, null)
I/flutter ( 3068): package:flutter/src/services/message_codecs.dart 551:7     StandardMethodCodec.decodeEnvelope
I/flutter ( 3068): package:flutter/src/services/platform_channel.dart 292:18  MethodChannel.invokeMethod
I/flutter ( 3068): package:fluttertoast/fluttertoast.dart 53:33               Fluttertoast.showToast
I/flutter ( 3068): package:example/ui/login_page.dart 198:18                  _LoginPageState.showAccountNameEmpty
I/flutter ( 3068): package:example/presenter/login_presenter.dart 19:12       LoginPresenter.login
I/flutter ( 3068): package:example/ui/login_page.dart 135:31                  _LoginPageState.buildBody.<fn>
I/flutter ( 3068): package:flutter/src/material/ink_well.dart 507:14          _InkResponseState._handleTap
I/flutter ( 3068): package:flutter/src/material/ink_well.dart 562:30          _InkResponseState.build.<fn>
I/flutter ( 3068): package:flutter/src/gestures/recognizer.dart 102:24        GestureRecognizer.invokeCallback
I/flutter ( 3068): package:flutter/src/gestures/tap.dart 242:9                TapGestureRecognizer._checkUp
I/flutter ( 3068): package:flutter/src/gestures/tap.dart 175:7                TapGestureRecognizer.handlePrimaryPointer
I/flutter ( 3068): package:flutter/src/gestures/recognizer.dart 315:9         PrimaryPointerGestureRecognizer.handleEvent
I/flutter ( 3068): package:flutter/src/gestures/pointer_router.dart 73:12     PointerRouter._dispatch
I/flutter ( 3068): package:flutter/src/gestures/pointer_router.dart 101:11    PointerRouter.route
I/flutter ( 3068): package:flutter/src/gestures/binding.dart 180:19           _WidgetsFlutterBinding&BindingBase&GestureBinding.handleEvent
I/flutter ( 3068): package:flutter/src/gestures/binding.dart 158:22           _WidgetsFlutterBinding&BindingBase&GestureBinding.dispatchEvent
I/flutter ( 3068): package:flutter/src/gestures/binding.dart 138:7            _WidgetsFlutterBinding&BindingBase&GestureBinding._handlePointerEvent
I/flutter ( 3068): package:flutter/src/gestures/binding.dart 101:7            _WidgetsFlutterBinding&BindingBase&GestureBinding._flushPointerEventQueue
I/flutter ( 3068): package:flutter/src/gestures/binding.dart 85:7             _WidgetsFlutterBinding&BindingBase&GestureBinding._handlePointerDataPacket
I/flutter ( 3068): dart:async/zone.dart 1136:13                               _rootRunUnary
I/flutter ( 3068): dart:async/zone.dart 1029:19                               _CustomZone.runUnary
I/flutter ( 3068): dart:async/zone.dart 931:7                                 _CustomZone.runUnaryGuarded
I/flutter ( 3068): dart:ui/hooks.dart 170:10                                  _invoke1
I/flutter ( 3068): dart:ui/hooks.dart 122:5                                   _dispatchPointerDataPacket
```
### Simple Mode

```
I/flutter ( 3068): PlatformException(error, Attempt to invoke virtual method 'java.lang.String java.lang.Object.toString()' on a null object reference, null)
I/flutter ( 3068): package:fluttertoast/fluttertoast.dart 53:33               Fluttertoast.showToast
I/flutter ( 3068): package:example/ui/login_page.dart 198:18                  _LoginPageState.showAccountNameEmpty
I/flutter ( 3068): package:example/presenter/login_presenter.dart 19:12       LoginPresenter.login
I/flutter ( 3068): package:example/ui/login_page.dart 135:31                  _LoginPageState.buildBody.<fn>
```

### Example

```dart
import 'package:flutter_stack_trace/flutter_stack_trace.dart';

//default simple mode
void main() => FlutterChain.capture(
      () {
        runApp(MyApp());
      },
    );

//just print in debug mode
//isShowTime default true
FlutterChain.print("test",isShowTime: false);

```
