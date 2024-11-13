import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  FocusNode focusNode = FocusNode();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    print('vip功能已经开发完成了');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyO):
              const NumberIncIntent(),
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyP):
              const NumberDesIntent(),
        },
        child: Actions(
          //Actions组件将意图映射到操作
          actions: <Type, Action<Intent>>{
            NumberIncIntent: IncNumberAction(incFunc: () {
              setState(() {
                _counter++;
              });
            }),
            NumberDesIntent: DesNumberAction(desFunc: () {
              setState(() {
                _counter--;
              });
            })
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  '你已经点击了很多次了,ivp分支',
                ),
                Focus(
                  focusNode: focusNode,
                  child: Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Vip',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NumberIncIntent extends Intent {
  const NumberIncIntent();
}

class NumberDesIntent extends Intent {
  const NumberDesIntent();
}

class IncNumberAction extends Action<NumberIncIntent> {
  IncNumberAction({required this.incFunc});
  final Function incFunc;

  @override
  Object? invoke(NumberIncIntent intent) {
    print('Increase.......');

    incFunc();

    return null;
  }
}

class DesNumberAction extends Action<NumberDesIntent> {
  DesNumberAction({required this.desFunc});
  final Function desFunc;

  @override
  Object? invoke(NumberDesIntent intent) {
    print('Descrease.......');

    desFunc();
    return null;
  }
}

