import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:im_knitter/model/pattern_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PatternSaveProvider extends ChangeNotifier {
  String _originPatternKey = '';
  PatternModel _pattern = PatternModel();
  PatternModel _newPattern = PatternModel();
  XFile? _pickedFile;

  PatternModel get pattern => _pattern;
  PatternModel get newPattern => _newPattern;
  XFile? get pickedFile => _pickedFile;

  /// 서버에서 도안 정보 가지고 오는 함수
  Future<void> getPattern(String patternKey) async {
    final ref = FirebaseDatabase.instance.ref();

    // TODO :: 키 값으로 조회
    final snapshots = await ref.child('patterns/$patternKey').get();

    if (snapshots.exists) {
      final data = Map<String, dynamic>.from(snapshots.value as Map);
      _pattern = PatternModel.fromJson(data);
      _newPattern = PatternModel.fromJson(data);
      _originPatternKey = patternKey;
    }

    notifyListeners();
  }

  Future<void> setPattern() async {
    String key = _originPatternKey.isEmpty ? DateFormat('yyyyMMddHHmmss').format(DateTime.now()) : _originPatternKey;
    DatabaseReference ref = FirebaseDatabase.instance.ref("patterns/$key");

    // 임시 이미지
    String imgUrl =
        'https://firebasestorage.googleapis.com/v0/b/imknitter.appspot.com/o/KakaoTalk_Photo_2022-12-29-13-33-59.jpeg?alt=media&token=32c79d63-6437-4697-aa21-8a304cb581d7';

    if (_pickedFile != null) {
      imgUrl = await uploadPhoto(file: _pickedFile!, key: key);
    }

    await ref.set({
      "patternGauge": _newPattern.patternGauge,
      "patternName": _newPattern.patternName,
      "patternOriginGauge": _newPattern.patternOriginGauge,
      "patternOriginYarn": _newPattern.patternOriginYarn.isEmpty ? {} : _newPattern.patternOriginYarn,
      "patternPrice": _newPattern.patternPrice,
      "patternShopLink": _newPattern.patternShopLink,
      "patternWriter": _newPattern.patternWriter,
      "patternWriterLink": "",
      "patternYarn": _newPattern.patternYarn.isEmpty ? {} : _newPattern.patternYarn,
      "patternImg": imgUrl,
    });
  }

  Future<String> uploadPhoto({required XFile file, required String key}) async {
    // 스토리지에 먼저 사진 업로드 하는 부분.
    final firebaseStorageRef = FirebaseStorage.instance;

    TaskSnapshot task = await firebaseStorageRef
        .ref() // 시작점
        .child('patterns') // collection 이름
        .child(key) // 업로드한 파일의 최종이름, 본인이 원하는 이름.
        .putFile(File(file.path)); //실제 이미지파일, 버전 ^7.0.0 에서는 onComplete 필요없음
    /*.onComplete; // 버전 ^4.0.1 에 해당 사항*/

    // 업로드 완료되면 데이터의 주소를 얻을수 있음, future object
    var downloadUrl = await task.ref.getDownloadURL();
    return downloadUrl;
  }

  void setPickedFile(XFile? file) {
    _pickedFile = file;
    notifyListeners();
  }

  void removePickedFile() {
    _pickedFile = null;
    _pattern.patternImg = '';
    notifyListeners();
  }

  void addTempOriginYarn() {
    _newPattern.patternOriginYarn.add('');
    notifyListeners();
  }

  void changeTempOriginYarn({required int index, required String yarn}) {
    _newPattern.patternOriginYarn[index] = yarn;
    notifyListeners();
  }

  void removeTempOriginYarn({required int index}) {
    _newPattern.patternOriginYarn.removeAt(index);
    notifyListeners();
  }

  void addTempYarn() {
    _newPattern.patternYarn.add('');
    notifyListeners();
  }

  void changeTempYarn({required int index, required String yarn}) {
    _newPattern.patternYarn[index] = yarn;
    notifyListeners();
  }

  void removeTempYarn({required int index}) {
    _newPattern.patternYarn.removeAt(index);
    notifyListeners();
  }

  void changePatternName({required String name}) {
    _newPattern.patternName = name;
    notifyListeners();
  }

  void changeWriterName({required String name}) {
    _newPattern.patternWriter = name;
    notifyListeners();
  }

  void changeShopLink({required String link}) {
    _newPattern.patternShopLink = link;
    notifyListeners();
  }

  void changePrice({required String price}) {
    _newPattern.patternPrice = price;
    notifyListeners();
  }

  void changeOriginGauge({required String gauge}) {
    _newPattern.patternOriginGauge = gauge;
    notifyListeners();
  }

  void changeGauge({required String gauge}) {
    _newPattern.patternGauge = gauge;
    notifyListeners();
  }
}
