import 'package:flutter/material.dart';

class Observer<T> extends StatelessWidget {
  @required
  final Stream<T> stream;

  @required
  final Function onSuccess;
  
  final Function onError;
  final Function onWaiting;

  Function get _defaultOnWaiting => (context) => Center(child: CircularProgressIndicator());
  Function get _defaultOnError => (context, error) => Text(error);

  const Observer({this.onError, this.onSuccess, this.stream, this.onWaiting});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          return (onError != null)
            ? onError(context, snapshot.error)
            : _defaultOnWaiting(context, snapshot.error);
        }

        if (snapshot.hasData) {
          T data = snapshot.data;
          return onSuccess(context, data);
        } else {
          return (onWaiting != null)
            ? onWaiting(context)
            : _defaultOnWaiting(context);
        }
      },
    );
  }
}