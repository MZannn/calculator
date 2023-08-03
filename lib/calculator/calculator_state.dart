part of 'calculator_cubit.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object?> get props => [];
}

class CalculatorInitial extends CalculatorState {}

class CalculatorLoaded extends CalculatorState {
  final String? textToDisplay;
  final String? result;
  final String? history;

  const CalculatorLoaded({
    this.history,
    this.textToDisplay,
    this.result,
  });
  @override
  List<Object?> get props => [
        history,
        textToDisplay,
        result,
      ];
}
