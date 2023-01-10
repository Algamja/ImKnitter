class PatternModel {
  String patternImg = '';
  String patternName = '';
  String patternWriter = '';
  String patternShopLink = '';
  String patternWriterLink = '';
  String patternPrice = '';
  List<String> patternOriginYarn = [];
  String patternOriginGauge = '';
  List<String> patternYarn = [];
  String patternGauge = '';

  PatternModel.fromJson(Map<dynamic, dynamic> json)
      : patternImg = json['patternImg'] ??
            'https://firebasestorage.googleapis.com/v0/b/imknitter.appspot.com/o/KakaoTalk_Photo_2022-12-29-13-33-59.jpeg?alt=media&token=32c79d63-6437-4697-aa21-8a304cb581d7',
        patternName = json['patternName'] ?? '',
        patternWriter = json['patternWriter'] ?? '',
        patternShopLink = json['patternShopLink'] ?? '',
        patternWriterLink = json['patternWriterLink'] ?? '',
        patternPrice = json['patternPrice'] ?? '',
        patternOriginYarn = (json['patternOriginYarn'] ?? []).map<String>((it) => it.toString()).toList(),
        patternOriginGauge = json['patternOriginGauge'] ?? '',
        patternYarn = (json['patternYarn'] ?? []).map<String>((it) => it.toString()).toList(),
        patternGauge = json['patternGauge'] ?? '';

  PatternModel();
}
