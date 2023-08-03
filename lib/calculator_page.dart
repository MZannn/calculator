import 'package:calculator/calculator/calculator_cubit.dart';
import 'package:calculator/constants.dart';
import 'package:flutter/material.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              child: BlocBuilder<CalculatorCubit, CalculatorState>(
                builder: (context, state) {
                  if (state is CalculatorLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            state.textToDisplay!,
                            style: const TextStyle(
                              fontSize: 50,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            state.history != ''
                                ? '${state.history} = ${state.result}'
                                : state.result!,
                            style: const TextStyle(
                              fontSize: 35,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
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
                  itemCount: widgetButton.length,
                  itemBuilder: (context, index) {
                    if (widgetButton[index]['text'] == "=") {
                      return TextButton(
                        onPressed: () {
                          context
                              .read<CalculatorCubit>()
                              .btnOnClick(widgetButton[index]['text']);
                        },
                        style: TextButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          enableFeedback: true,
                        ),
                        child: widgetButton[index]['widget'],
                      );
                    } else {
                      return TextButton(
                        style: TextButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          context
                              .read<CalculatorCubit>()
                              .btnOnClick(widgetButton[index]['text']);
                        },
                        child: widgetButton[index]['widget'],
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
