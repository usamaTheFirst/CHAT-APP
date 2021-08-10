import 'package:flutter/material.dart';

class One extends StatefulWidget {
  const One({Key key}) : super(key: key);

  @override
  _OneState createState() => _OneState();
}

class _OneState extends State<One> {
  String _text;
  func(text) {
    _text = text;
  }

  @override
  Widget build(BuildContext context) {
    print('Build One');

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Two(func: func),
            TextButton(
              child: Text('Press Me'),
              onPressed: () {
                print(_text);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Two extends StatefulWidget {
  const Two({Key key, this.func}) : super(key: key);
  final Function func;

  @override
  _TwoState createState() => _TwoState();
}

class _TwoState extends State<Two> {
  String text;

  @override
  Widget build(BuildContext context) {
    print('Build Two');
    return TextField(
      onChanged: (value) {
        setState(() {
          text = value;
          widget.func(text);
        });
      },
    );
  }
}
