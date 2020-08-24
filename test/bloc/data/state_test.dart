import 'package:antassistant/bloc/data/state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("DataLoaded state", () {
    test("Requires a non-null data list", () {
      expect(() => DataLoaded(data: null), throwsAssertionError);
    });

    test("DataLoaded state created properly", () {
      DataLoaded(data: List());
    });
  });
}
