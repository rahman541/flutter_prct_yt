import 'dart:async';

mixin Validation {
  static bool isEmail(String email) => email.contains('@');

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      if (isEmail(value)) {
        sink.add(value);
      } else {
        sink.addError('Our message error');
      }
    }
  );

  final validateSubject = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      int len = value.length;
      if (len == 0) sink.addError('`SUBJECT` cannot be empty.');
      else if (len < 4) {
        return sink.addError('`SUBJECT` mus be longer than 4 character');
      } else {
        sink.add(value);
      }
      return null;
    }
  );
}