import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:im_knitter/model/pattern_model.dart';

class PatternDetailProvider extends ChangeNotifier {
  String _originPatternKey = '';
  PatternModel _pattern = PatternModel();

  PatternModel get pattern => _pattern;
  String get originPatternKey => _originPatternKey;

  /// 서버에서 도안 정보 가지고 오는 함수
  Future<void> getPattern(String patternKey) async {
    final ref = FirebaseDatabase.instance.ref();

    final snapshots = await ref.child('patterns/$patternKey').get();

    if (snapshots.exists) {
      final data = Map<String, dynamic>.from(snapshots.value as Map);
      _pattern = PatternModel.fromJson(data);
      _originPatternKey = patternKey;
    }

    notifyListeners();
  }

  /// 서버에서 도안 정보 가지고 오는 함수
  Future<void> removePattern(String patternKey) async {
    final ref = FirebaseDatabase.instance.ref();
    await ref.child('patterns/$patternKey').remove();
    notifyListeners();
  }
}
