extension DynamicMapX on Map<dynamic, dynamic> {
  Map<String, dynamic> toStringKeyedMap() =>
      map((key, value) => MapEntry(key.toString(), value));
}
