import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial());

  List<String> expression = [];
  String result = '';
  String textToDisplay = '';
  String history = '';

  void btnOnClick(String value) {
    if (value == "AC") {
      textToDisplay = '';
      expression.clear();
      history = '';
      result = '';
    } else if (value == "C") {
      textToDisplay = '';
    } else if (value == "=") {
      if (textToDisplay.isNotEmpty) {
        expression.add(textToDisplay);
        textToDisplay = '';
        history = expression.join();
        try {
          result = calculateResult(expression).toString();
          expression.clear();
          textToDisplay = result;
        } catch (e) {
          result = 'Error';
        }
      }
    } else if (value == "backspace") {
      if (textToDisplay.isNotEmpty) {
        textToDisplay = textToDisplay.substring(0, textToDisplay.length - 1);
      }
    } else if (value == "+" || value == "-" || value == "x" || value == "/") {
      if (textToDisplay.isNotEmpty) {
        expression.add(textToDisplay.split(value).join());
        expression.add(value);
        textToDisplay = '';
        result = expression.join();
      }
    } else {
      textToDisplay += value;
      result = expression.join();
    }
    emit(
      CalculatorLoaded(
        history: history,
        textToDisplay: textToDisplay,
        result: result,
      ),
    );
  }

  num calculateResult(List<String> expression) {
    final rpnQueue = <String>[];
    final operatorStack = <String>[];

    for (final token in expression) {
      if (isNumber(token)) {
        rpnQueue.add(token);
      } else if (isOperator(token)) {
        while (operatorStack.isNotEmpty &&
            isOperator(operatorStack.last) &&
            getPrecedence(token) <= getPrecedence(operatorStack.last)) {
          rpnQueue.add(operatorStack.removeLast());
        }
        operatorStack.add(token);
      }
    }

    while (operatorStack.isNotEmpty) {
      rpnQueue.add(operatorStack.removeLast());
    }

    final resultStack = <num>[];
    for (final token in rpnQueue) {
      if (isNumber(token)) {
        resultStack.add(num.parse(token));
      } else if (isOperator(token)) {
        final number2 = resultStack.removeLast();
        final number1 = resultStack.removeLast();
        switch (token) {
          case "+":
            resultStack.add(number1 + number2);
            break;
          case "-":
            resultStack.add(number1 - number2);
            break;
          case "x":
            resultStack.add(number1 * number2);
            break;
          case "/":
            resultStack.add(number1 / number2);
            break;
        }
      }
    }

    if (resultStack.length == 1) {
      return resultStack.first;
    } else {
      throw Exception("Invalid expression");
    }
  }

  bool isNumber(String token) {
    return double.tryParse(token) != null;
  }

  bool isOperator(String token) {
    return ["+", "-", "x", "/"].contains(token);
  }

  int getPrecedence(String operator) {
    if (operator == "+" || operator == "-") {
      return 1;
    } else if (operator == "x" || operator == "/") {
      return 2;
    }
    return 0;
  }
}
