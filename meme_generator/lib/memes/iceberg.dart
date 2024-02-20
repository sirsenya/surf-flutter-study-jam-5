import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meme_generator/riverpod/current_values/current_values.dart';

class Iceberg extends ConsumerStatefulWidget {
  final String name = "Basic template";
  const Iceberg({
    super.key,
  });

  @override
  ConsumerState<Iceberg> createState() => _IcebergState();
}

class _IcebergState extends ConsumerState<Iceberg> {
  final int quantityOfFields = 8;
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
      width: MediaQuery.of(context).size.height / 2.65,
      child: Text(
        ref.watch(currentValuesProvider).when(
            data: (texts) => texts[index],
            error: (e, t) => "exception",
            loading: () => "loading"),
        style: TextStyle(
            color: Colors.white,
            backgroundColor: Colors.black.withOpacity(0.2)),
        overflow: TextOverflow.clip,
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
              Image.asset("images/iceberg_template.jpeg",
                  fit: BoxFit.fitHeight),
              Column(children: [
                textBox(ratio: 8.3, index: 0),
                textBox(ratio: 8.3, index: 1),
                textBox(ratio: 7, index: 2),
                textBox(ratio: 8, index: 3),
                textBox(ratio: 7.7, index: 4),
                textBox(ratio: 8.7, index: 5),
                textBox(ratio: 8, index: 6),
                textBox(ratio: 8.24, index: 7),
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
                    style: TextStyle(color: Colors.white),
                    onChanged: (_) => ref
                        .read(currentValuesProvider.notifier)
                        .addValue(value: _, index: index),
                  )),
        )
      ],
    );
  }
}
