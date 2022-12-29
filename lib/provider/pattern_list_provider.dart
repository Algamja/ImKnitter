import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:im_knitter/model/pattern_model.dart';

class PatternListProvider extends ChangeNotifier {
  final List<PatternModel> _patterns = [];

  List<PatternModel> get patterns => _patterns;

  Future<void> getPatterns() async {
    _patterns.clear();
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('patterns').get();

    if (snapshot.exists) {
      for (var msgSnapshot in snapshot.children) {
        final data = Map<String, dynamic>.from(msgSnapshot.value as Map);
        PatternModel patternModel = PatternModel.fromJson(data);

        _patterns.add(patternModel);
      }
      notifyListeners();
    }
  }
}
