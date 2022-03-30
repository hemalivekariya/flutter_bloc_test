abstract class NumberState {
  int number;

  NumberState({this.number = 0});
}

class InitialNumber extends NumberState {}

class NumberChanged extends NumberState {
  final int newNumber;

  NumberChanged({required this.newNumber}) : super(number: newNumber);
}
