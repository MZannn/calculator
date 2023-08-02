import 'package:calculator/calculator/calculator_cubit.dart';
import 'package:calculator/constants.dart';
import 'package:flutter/material.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    num number1 = 0;
    num number2 = 0;
    String result;
    String operator;
    String textToDisplay = '';
    String history = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator App',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<CalculatorCubit, CalculatorState>(
            builder: (context, state) {
              if (state is CalculatorLoaded) {
                textToDisplay = state.textToDisplay!;
                return Expanded(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      textToDisplay,
                      style: const TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          Column(
            children: [
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemCount: widget.length,
                  itemBuilder: (context, index) {
                    if (widget[index] == widget.last) {
                      return TextButton(
                        onPressed: () {
                          context.read<CalculatorCubit>().btnOnClick(
                                data.last,
                              );
                        },
                        style: TextButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.black,
                          enableFeedback: true,
                        ),
                        child: widget[index],
                      );
                    } else {
                      return TextButton(
                        style: TextButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          context.read<CalculatorCubit>().btnOnClick(
                                textToDisplay + data[index],
                              );
                        },
                        child: widget[index],
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
