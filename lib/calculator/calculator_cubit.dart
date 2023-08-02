import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial());
  num number1 = 0;
  num number2 = 0;
  String result = '';
  String operator = '';
  String history = '';
  String textToDisplay = '';

  void btnOnClick(String value) {
    print(value.toString());
    emit(CalculatorInitial());
    if (value == "AC") {
      emit(
        const CalculatorLoaded(
          textToDisplay: '',
          number1: 0,
          number2: 0,
          result: '',
          history: '',
        ),
      );
    } else if (value == "+" ||
        value == "x" ||
        value == "-" ||
        value == "/" ||
        value == "%") {
      number1 = int.parse(textToDisplay);
      result = '';
      operator = value;
      textToDisplay = '';
    } else if (value == "=") {
      number2 = int.parse(textToDisplay);
      if (operator == "+") {
        result = (number1 + number2).toString();
        history = number1.toString() + operator + number2.toString();
      }
    } else if (value == "backspace") {
    } else {
      number1 = int.parse(value);
      emit(
        CalculatorLoaded(
          textToDisplay: textToDisplay + value,
        ),
      );
    }
  }
}
