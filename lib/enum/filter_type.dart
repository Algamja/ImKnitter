enum FilterType {
  newest,
  oldest,
}

extension FilterTypeX on FilterType {
  String get enumToText {
    switch (this) {
      case FilterType.newest:
        return "최신순";
      case FilterType.oldest:
        return "과거순";
      default:
        return "최신순";
    }
  }
}

FilterType textToFilterType(String text) {
  switch (text) {
    case '최신순':
      return FilterType.newest;
    case '과거순':
      return FilterType.oldest;
    default:
      return FilterType.newest;
  }
}
