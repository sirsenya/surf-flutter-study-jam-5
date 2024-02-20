import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meme_generator/riverpod/current_values/current_values.dart';

class IntelligenceLevel extends ConsumerStatefulWidget {
  final String name = "Basic template";
  const IntelligenceLevel({
    super.key,
  });

  @override
  ConsumerState<IntelligenceLevel> createState() => _IcebergState();
}

class _IcebergState extends ConsumerState<IntelligenceLevel> {
  final int quantityOfFields = 4;
  late List<TextEditingController> textEditingControllers;

  @override
  void initState() {
    textEditingControllers =
        List.generate(quantityOfFields, (index) => TextEditingController());
    super.initState();
  }

  @override
  void dispose() {
    for (var element in textEditingControllers) {
      element.dispose();
    }
    super.dispose();
  }

  TextStyle demotivationStyle = const TextStyle(
    fontFamily: 'Impact',
    fontSize: 40,
    color: Colors.white,
  );

  double get screenHeight => MediaQuery.of(context).size.height;
  double get screenWidth => MediaQuery.of(context).size.width;

  SizedBox textBox({required double ratio, required int index}) {
    return SizedBox(
      height: (screenHeight * 2 / 3) / ratio,
      width: MediaQuery.of(context).size.height / 4.4,
      child: Text(
        ref.watch(currentValuesProvider).when(
            data: (texts) => texts[index],
            error: (e, t) => "exception",
            loading: () => "loading"),
        style: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 2 / 3,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Image.asset("images/intelligence.png", fit: BoxFit.fitHeight),
              Column(children: [
                textBox(ratio: 4, index: 0),
                textBox(ratio: 3.9, index: 1),
                textBox(ratio: 4.3, index: 2),
                textBox(ratio: 3.85, index: 3),
              ])
            ],
          ),
        ),
        SizedBox(
          height: screenHeight * 1 / 3,
          child: ListView.builder(
              itemCount: quantityOfFields,
              itemBuilder: (context, index) => TextField(
                    controller: textEditingControllers[index],
                    onChanged: (_) => ref
                        .read(currentValuesProvider.notifier)
                        .addValue(value: _, index: index),
                  )),
        )
      ],
    );
  }
}
