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
      : patternImg = json['patternImg'] ?? '',
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
