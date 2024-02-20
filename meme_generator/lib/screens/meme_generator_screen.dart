import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meme_generator/memes/demotivator.dart';
import 'package:meme_generator/memes/iceberg.dart';
import 'package:meme_generator/memes/intelligence_level.dart';
import 'package:meme_generator/riverpod/current_template/current_template.dart';
import 'package:meme_generator/screens/pick_template_screen.dart';

class MemeGeneratorScreen extends ConsumerStatefulWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MemeGeneratorScreen> createState() =>
      _MemeGeneratorScreenState();
}

class _MemeGeneratorScreenState extends ConsumerState<MemeGeneratorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PickTemplateScreen(),
          ),
        ),
        child: const Text(
          ">",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ColoredBox(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ref.watch(currentTemplateProvider).when(
                        data: (currentTemplate) => Column(
                          children: [
                            Text(currentTemplate.name,
                                style: const TextStyle(color: Colors.white)),
                            switch (currentTemplate) {
                              Template.demotivator => const Demotivator(),
                              Template.iceberg => const Iceberg(),
                              Template.intelligenceLevel =>
                                const IntelligenceLevel(),
                            }
                          ],
                        ),
                        error: (e, t) => throw Exception(e),
                        loading: () => const CircularProgressIndicator(),
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
