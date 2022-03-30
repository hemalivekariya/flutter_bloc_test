import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/number/new_number_screen.dart';

import '../bloc/number_bloc/number.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({Key? key}) : super(key: key);

  @override
  _NumberScreenState createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
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
        title: const Text('Number bloc test'),
      ),
      body: BlocListener<NumberBloc, NumberState>(
        listener: (context, state) {
          print(
              'blocTest listener receive number state: $state number: ${state.number}');
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

              /// NEW SCREEN WITH USING OLD BLOC
              _newScreenWithOldBloc(),

              /// NEW SCREEN WITH NEW BLOC CREATE
              _newScreenWithNewBlocButton(),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '0',
            onPressed: () {
              _numberBloc.add(IncrementNumber());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: '1',
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
        print(
            'blocTest builder receive number state: $state number: ${state.number}');
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
            builder: (context) => BlocProvider<NumberBloc>(
              create: (context) => NumberBloc(),
              child: const NewNumberScreen(),
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
            builder: (context) => const NewNumberScreen(),
          ),
        );
      },
      child: const Text('Go to new screen with old bloc'),
    );
  }
}
