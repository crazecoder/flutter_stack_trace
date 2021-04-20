import 'package:flutter_stack_trace/flutter_stack_trace.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds one to input values', () {
    FlutterChain.capture(() =>
          throw "test print exception for long detail :You can transfer this package to a verified publisher if you are a member of the publisher. Transferring the package removes the current uploaders, so that only the members of the publisher can upload new versions.Upgrading to verified publishers is an irreversible operation. Packages can be transferred between publishers, but they can't be converted back to legacy uploader ownership.");
    },);
}

