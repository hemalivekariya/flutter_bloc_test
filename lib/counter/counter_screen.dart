import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/counter/new_counter_screen.dart';

import '../bloc/counter_bloc/counter.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  late CounterBloc _counterBloc;

  @override
  void initState() {
    super.initState();
    _counterBloc = BlocProvider.of<CounterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter bloc test'),
      ),
      body: BlocListener<CounterBloc, CounterState>(
        listener: (context, state) {
          print(
              'blocTest listener receive counter state: $state number: ${state.number}');
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ///TEMP TEXT
              const Text(
                'You have pushed the button this many times:',
              ),

              /// ORIGINAL NUMBER
              _counterValueWidget(),

              /// NEW SCREEN WITH USING OLD BLOC
              _newScreenWithOldBloc(),

              /// NEW SCREEN WITH NEW BLOC CREATE
              _newScreenWithNewBlocButton(),

              /// NEW SCREEN WITHOUT PASSING BLOC
              _newScreenWithoutBloc(),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '2',
            onPressed: () {
              //ui -> event
              _counterBloc.add(IncrementCounter());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: '3',
            onPressed: () {
              //ui -> event
              _counterBloc.add(DecrementCounter());
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  Widget _counterValueWidget() {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        print(
            'blocTest builder receive counter state: $state number: ${state.number}');
        return Text(
          '${state.number}',
          style: Theme.of(context).textTheme.headline4,
        );
      },
    );
  }

  Widget _newScreenWithNewBlocButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider<CounterBloc>(
              create: (context) => CounterBloc(),
              child: const NewCounterScreen(),
            ),
          ),
        );
      },
      child: const Text('Go to new screen with new bloc'),
    );
  }

  Widget _newScreenWithOldBloc() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _counterBloc,
              child: const NewCounterScreen(),
            ),
          ),
        );
      },
      child: const Text('Go to new screen with old bloc'),
    );
  }

  Widget _newScreenWithoutBloc() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NewCounterScreen(),
          ),
        );
      },
      child: const Text('Go to new screen without old bloc'),
    );
  }
}
