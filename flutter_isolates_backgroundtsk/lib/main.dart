import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PerformancePage(),
    );
  }
}

class PerformancePage extends StatefulWidget {
  @override
  _PerformancePageState createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  //
  Future<void> computeFuture = Future.value();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Performance using Isolate'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AnimationWidget(),
                addButton1(),
                addButton2(),
                AnimationWidget(),
                AnimationWidget(),
                AnimationWidget(),

//              RaisedButton(
//                onPressed: () {},
//              )
              ],
            ),
          ),
        ),
      ),
    );
  }

  addButton1() {
    return FutureBuilder<void>(
      future: computeFuture,
      builder: (context, snapshot) {
        return OutlineButton(
          child: const Text('Main Isolate'),
          onPressed: createMainIsolateCallback(context, snapshot),
        );
      },
    );
  }

  addButton2() {
    return FutureBuilder<void>(
      future: computeFuture,
      builder: (context, snapshot) {
        return OutlineButton(
          child: const Text('Secondary Isolate'),
          onPressed: createSecondaryIsolateCallback(context, snapshot),
        );
      },
    );
  }

  VoidCallback createMainIsolateCallback(
      BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return () {
        setState(() {
          computeFuture = computeOnMainIsolate().then((val) {
            showSnackBar(context, 'Main Isolate Done $val');
          });
        });
      };
    } else {
      return null;
    }
  }

  VoidCallback createSecondaryIsolateCallback(
      BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return () {
        setState(() {
          computeFuture = computeOnSecondaryIsolate().then((val) {
            showSnackBar(context, 'Secondary Isolate Done $val');
          });
        });
      };
    } else {
      return null;
    }
  }

  Future<int> computeOnMainIsolate() async {
    return await Future.delayed(Duration(milliseconds: 100), () => fib(40));
  }

  Future<int> computeOnSecondaryIsolate() async {
    return await compute(fib, 40);
  }

  showSnackBar(context, message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}

int fib(int n) {
  int number1 = n - 1;
  int number2 = n - 2;
  if (0 == n) {
    return 0;
  } else if (1 == n) {
    return 1;
  } else {
    return (fib(number1) + fib(number2));
  }
}

  class AnimationWidget extends StatefulWidget {
    @override
    AnimationWidgetState createState() {
      return AnimationWidgetState();
    }
  }

  class AnimationWidgetState extends State<AnimationWidget>
      with TickerProviderStateMixin {
    //
    AnimationController _animationController;
    Animation<BorderRadius> _borderRadius;

    @override
    void initState() {
      super.initState();
      _animationController =
          AnimationController(duration: const Duration(seconds: 1), vsync: this)
            ..addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                _animationController.reverse();
              } else if (status == AnimationStatus.dismissed) {
                _animationController.forward();
              }
            });

      _borderRadius = BorderRadiusTween(
        begin: BorderRadius.circular(100.0),
        end: BorderRadius.circular(0.0),
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ));

      _animationController.forward();
    }

    @override
    Widget build(BuildContext context) {
      return AnimatedBuilder(
        animation: _borderRadius,
        builder: (context, child) {
          return Center(
            child: Container(
              child: FlutterLogo(
                size: 200,
              ),
              alignment: Alignment.bottomCenter,
              width: 350,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  colors: [Colors.blueAccent, Colors.redAccent],
                ),
                borderRadius: _borderRadius.value,
              ),
            ),
          );
        },
      );
    }

    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  }
