import 'package:antassistant/bloc/auth/state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Authenticated state", () {
    test("Requires a non-null credentials list", () {
      expect(() => Authenticated(credentials: null), throwsAssertionError);
    });

    test("Requires a not empty credentials list", () {
      expect(() => Authenticated(credentials: List()), throwsAssertionError);
    });
  });
}
