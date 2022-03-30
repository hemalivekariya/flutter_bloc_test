import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/bloc/counter_bloc/counter.dart';
import 'package:flutter_bloc_test/bloc/number_bloc/number.dart';
import 'package:flutter_bloc_test/counter/counter_screen.dart';

import 'number/number_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NumberBloc>(
      create: (context) => NumberBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _counterButton(),
            const SizedBox(
              height: 20,
            ),
            _numberButton(),
          ],
        ),
      ),
    );
  }

  Widget _counterButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider<CounterBloc>(
              create: (context) => CounterBloc(),
              child: const CounterScreen(),
            ),
          ),
        );
      },
      child: const Text('Go to counter screen'),
    );
  }

  Widget _numberButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NumberScreen(),
          ),
        );
      },
      child: const Text('Go to number screen'),
    );
  }
}
