class EnumFunctions<T> {
  static T getEnumFromString<T>(Iterable<T> values, String value) {
    return values.firstWhere((type) => type.toString().split(".").last == value,
        orElse: () => null);
  }

  static String getStringFromEnum(enumValue) {
    return enumValue.toString().split(".").last;
  }
}
