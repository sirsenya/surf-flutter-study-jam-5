import 'dart:async';
import 'package:meme_generator/riverpod/current_template/current_template.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_values.g.dart';

//Creates idb databases
@riverpod
class CurrentValues extends _$CurrentValues {
  // IdbFactory? idbFactory = getIdbFactory();
  // late Database db;

  @override
  Future<List<String>> build() async {
    Template currentTemplate = await ref.watch(currentTemplateProvider.future);
    switch (currentTemplate) {
      case Template.iceberg:
        return List.filled(8, "");
      case Template.demotivator:
        return List.filled(2, "");
      case Template.intelligenceLevel:
        return List.filled(4, "");
      default:
        return <String>[];
    }
  }

  Future<void> addValue({
    required String value,
    required int index,
  }) async {
    final previousState = await future;
    List<String> newState = List.from(previousState);
    newState[index] = value;
    state = AsyncData(newState);
    ref.notifyListeners();
  }

  // void clear() {
  //   Map<String, String> emptyMap = {};
  //   state = AsyncData(emptyMap);
  //   ref.notifyListeners();
  // }
}
