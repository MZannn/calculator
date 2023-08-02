part of 'calculator_cubit.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object> get props => [];
}

class CalculatorInitial extends CalculatorState {}

class CalculatorLoaded extends CalculatorState {
  final String? textToDisplay;
  final String? result;
  final String? history;
  final num? number1;
  final num? number2;
  final String? operator;
  const CalculatorLoaded({
    this.textToDisplay,
    this.result,
    this.history,
    this.number1,
    this.number2,
    this.operator,
  });

  @override
  List<Object> get props =>
      [textToDisplay!, result!, history!, number1!, number2!, operator!];
}
