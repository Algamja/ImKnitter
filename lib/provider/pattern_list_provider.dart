import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:im_knitter/enum/filter_type.dart';
import 'package:im_knitter/model/pattern_model.dart';

class PatternListProvider extends ChangeNotifier {
  final Map<String, PatternModel> _patterns = {};
  final Map<String, PatternModel> _searchedPatterns = {};
  bool _searched = false;
  String _searchedText = '';
  FilterType _filterType = FilterType.newest;

  Map<String, PatternModel> get patterns => _patterns;
  Map<String, PatternModel> get searchedPatterns => _searchedPatterns;
  bool get searched => _searched;
  FilterType get filterType => _filterType;

  /// 서버에서 도안 정보 가지고 오는 함수
  Future<void> getPatterns() async {
    _patterns.clear();
    final ref = FirebaseDatabase.instance.ref();

    // TODO :: limit 추가필요할듯
    final snapshot = await ref.child('patterns').orderByKey().get();

    if (snapshot.exists) {
      List<DataSnapshot> datas = [];
      if (_filterType == FilterType.newest) {
        datas = snapshot.children.toList();
        datas = datas.reversed.toList();
      } else {
        datas = snapshot.children.toList();
      }
      for (var snapshot in datas) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        PatternModel patternModel = PatternModel.fromJson(data);

        _patterns[snapshot.key!] = patternModel;
      }
    }
    notifyListeners();
  }

  /// 서버에서 도안 정보 검색하는 함수
  Future<void> searchPatterns(String searchText) async {
    // 검색 내용이 빈칸이면 검색하지 않는다.
    if (searchText.isNotEmpty) {
      // 검색 상태를 검색중으로 변경한다.
      _searched = true;
      _searchedText = searchText;
      _searchedPatterns.clear();
      final ref = FirebaseDatabase.instance.ref();

      // DB에서 우선 모든 데이터를 가지고 온다.
      final snapshots = await ref.child('patterns').orderByKey().get();

      if (snapshots.exists) {
        List<DataSnapshot> datas = [];
        if (_filterType == FilterType.newest) {
          datas = snapshots.children.toList();
          datas = datas.reversed.toList();
        } else {
          datas = snapshots.children.toList();
        }

        for (var snapshot in datas) {
          final data = Map<String, dynamic>.from(snapshot.value as Map);
          PatternModel patternModel = PatternModel.fromJson(data);

          // 패턴 이름 중에서 겹치는 내용이 있는 데이터만 저장한다.
          if (patternModel.patternName.toLowerCase().contains(searchText.toLowerCase())) {
            _searchedPatterns[snapshot.key!] = patternModel;
          }
        }
      }
      notifyListeners();
    }
  }

  /// 검색 상태 취소하는 함수
  void setSearchCancel() {
    _searched = false;
    notifyListeners();
  }

  void changeFilter(FilterType type) {
    _filterType = type;

    searchPatterns(_searchedText);
    getPatterns();
  }
}
