abstract class CounterState {
  int number;

  CounterState({this.number = 0});
}

class InitialCounter extends CounterState {}

class CounterChanged extends CounterState {
  final int newNumber;

  CounterChanged({required this.newNumber}) : super(number: newNumber);
}