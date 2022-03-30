import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/bloc/number_bloc/number.dart';

class NewNumberScreen extends StatefulWidget {
  const NewNumberScreen({Key? key}) : super(key: key);

  @override
  _NewNumberScreenState createState() => _NewNumberScreenState();
}

class _NewNumberScreenState extends State<NewNumberScreen> {
  late NumberBloc _numberBloc;

  @override
  void initState() {
    super.initState();
    _numberBloc = BlocProvider.of<NumberBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Number bloc test'),
      ),
      body: BlocListener<NumberBloc, NumberState>(
        listener: (context, state) {
          print(
              'blocTest listener receive new number state: $state number: ${state.number}');
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
              _numberValueWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '6',
            onPressed: () {
              _numberBloc.add(IncrementNumber());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: '7',
            onPressed: () {
              _numberBloc.add(DecrementNumber());
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  Widget _numberValueWidget() {
    return BlocBuilder<NumberBloc, NumberState>(
      builder: (context, state) {
        print('blocTest builder receive new number state: $state number: ${state.number}');
        return Text(
          '${state.number}',
          style: Theme.of(context).textTheme.headline4,
        );
      },
    );
  }
}
