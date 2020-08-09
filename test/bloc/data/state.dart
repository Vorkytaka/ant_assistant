import 'package:antassistant/bloc/data/state.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("DataLoaded state", () {
    test("Requires a non-null data list", () {
      expect(() => DataLoaded(data: null), throwsAssertionError);
    });

    test("Requires a not empty data list", () {
      expect(() => DataLoaded(data: List()), throwsAssertionError);
    });

    test("DataLoaded state created properly", () {
      DataLoaded(
          data: List()
            ..add(UserData(
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              800,
            )));
    });
  });
}
