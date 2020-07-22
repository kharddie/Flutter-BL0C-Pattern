import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/counter_bloc.dart';
import 'counter_event.dart';
import 'package:flutter_bloc_pattern/shared/bottom_nav.dart';

class BlocPattern extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Block Pattern', style: Theme.of(context).textTheme.headline5),
      ),
      body: BlocPatternPage(),
      bottomNavigationBar: AppBottomNav(),
    );
  }
}

class BlocPatternPage extends StatefulWidget {
  BlocPatternPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BlocPatternPageState createState() => _BlocPatternPageState();
}

class _BlocPatternPageState extends State<BlocPatternPage> {
  final _bloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: StreamBuilder(
            stream: _bloc.counter,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(width: 2.0, color: const Color(0xFFFFFF9FFF)),
                ),
                margin: EdgeInsets.all(30),
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('You have pushed the button this many times:'),
                    Text(
                      '${snapshot.data}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            FloatingActionButton(
              heroTag: 'btn-increment',
              onPressed: () => _bloc.counterEventSink.add(IncrementEvent()),
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              heroTag: 'btn-decrement',
              onPressed: () => _bloc.counterEventSink.add(DecrementEvent()),
              tooltip: 'Decrement',
              child: Icon(Icons.remove),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
