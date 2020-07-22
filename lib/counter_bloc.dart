import 'dart:async';

import 'counter_event.dart';

class CounterBloc {
  int _counter = 0;
  final _counterStateController = StreamController<int>();

  StreamSink<int> get _incounter => _counterStateController.sink;
  //for state exposing only a stream which is output data.
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventsController = StreamController<CounterEvent>();

  //For events exposing only a sink  which is an input
  Sink<CounterEvent> get counterEventSink => _counterEventsController.sink;

  CounterBloc() {
    //when ever theres a new event we want to map it to a new state
    _counterEventsController.stream.listen(_mapEventsToState);
  }

  void _mapEventsToState(CounterEvent event) {
    if (event is IncrementEvent)
      _counter++;
    else
      _counter--;

    _incounter.add(_counter);

    //print(_incounter);
  }

  void dispose() {
    _counterEventsController.close();
    _counterStateController.close();
  }
}
