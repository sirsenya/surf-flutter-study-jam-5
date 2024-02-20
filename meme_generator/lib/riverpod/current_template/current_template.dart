import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_template.g.dart';

enum Template {
  demotivator,
  intelligenceLevel,
  iceberg,
}

@riverpod
class CurrentTemplate extends _$CurrentTemplate {
  @override
  Future<Template> build() async {
    return Template.demotivator;
  }

  Future<void> changeCurrentTemplate({
    required Template template,
  }) async {
    state = AsyncData(template);
    ref.notifyListeners();
  }

  // void clear() {
  //   Map<String, String> emptyMap = {};
  //   state = AsyncData(emptyMap);
  //   ref.notifyListeners();
  // }
}
