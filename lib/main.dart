import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Key Presses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FocusNode focus;
  Set<LogicalKeyboardKey> _pressedKeys;

  @override
  void initState() {
    focus = FocusNode(canRequestFocus: true, onKey: _onKey);
    focus.requestFocus();
    super.initState();
  }

  bool _onKey(FocusNode node, RawKeyEvent event) {
    // Whenever a press occurs, re-build.
    setState(() {
      _pressedKeys = RawKeyboard.instance.keysPressed;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Focus(
        focusNode: focus,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Press a key'),
              if (_pressedKeys != null)
                ..._pressedKeys
                    .map(
                      (key) => Text(
                        key.debugName,
                      ),
                    )
                    .toList(growable: false),
            ],
          ),
        ),
      ),
    );
  }
}
