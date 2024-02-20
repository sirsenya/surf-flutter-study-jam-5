import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meme_generator/riverpod/current_template/current_template.dart';

class PickTemplateScreen extends ConsumerWidget {
  const PickTemplateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: List.generate(
              Template.values.length,
              (index) => InkWell(
                child: Text(
                  Template.values[index].name,
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
                onTap: () {
                  ref
                      .read(currentTemplateProvider.notifier)
                      .changeCurrentTemplate(template: Template.values[index]);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
