// Borrow this function https://pub.dev/packages/dson_core
// Tried importing dson_core in pubspec.yaml, but had dependency version
// conflic with mockito
bool isPrimitive(value) =>
    value is String || value is num || value is bool || value == null;
