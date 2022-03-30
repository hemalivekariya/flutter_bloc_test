import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter_bloc/counter.dart';

class NewCounterScreen extends StatefulWidget {
  const NewCounterScreen({Key? key}) : super(key: key);

  @override
  _NewNCounterScreenState createState() => _NewNCounterScreenState();
}

class _NewNCounterScreenState extends State<NewCounterScreen> {
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
        title: const Text('New Counter bloc test'),
      ),
      body: BlocListener<CounterBloc, CounterState>(
        listener: (context, state) {
          print(
              'blocTest listener receive new counter state: $state number: ${state.number}');
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
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '4',
            onPressed: () {
              _counterBloc.add(IncrementCounter());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: '5',
            onPressed: () {
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
        print('blocTest builder receive new counter state: $state number: ${state.number}');
        return Text(
          '${state.number}',
          style: Theme.of(context).textTheme.headline4,
        );
      },
    );
  }
}
