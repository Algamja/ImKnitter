import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:im_knitter/model/pattern_model.dart';

class PatternWriteProvider extends ChangeNotifier {
  PatternModel _pattern = PatternModel();

  PatternModel get pattern => _pattern;

  /// 서버에서 도안 정보 가지고 오는 함수
  Future<void> getPatterns(String patternKey) async {
    final ref = FirebaseDatabase.instance.ref();

    // TODO :: 키 값으로 조회
    final snapshots = await ref.child('patterns/$patternKey').get();

    if (snapshots.exists) {
      DataSnapshot snapshot = snapshots.children.toList().first;
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      _pattern = PatternModel.fromJson(data);
    }
    notifyListeners();
  }

  void setPatternImg() {}
}
