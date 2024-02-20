// import 'dart:async';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// part 'saved_memes.g.dart';


// //Creates idb databases
// @riverpod
// class SavedMemes extends _$SavedMemes {
//   // IdbFactory? idbFactory = getIdbFactory();
//   // late Database db;

//   @override
//   Future<Template> build() async {
//     return Template.demotivator;
//   }

//   Future<void> changeSavedMemes({
//     required Template template,
//   }) async {
//     state = AsyncData(template);
//     ref.notifyListeners();
//   }

//   // void clear() {
//   //   Map<String, String> emptyMap = {};
//   //   state = AsyncData(emptyMap);
//   //   ref.notifyListeners();
//   // }
// }
