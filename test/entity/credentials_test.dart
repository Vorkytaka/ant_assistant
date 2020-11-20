import 'package:antassistant/entity/credentials.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Credentials", () {
    test("Requires a non-null username", () {
      expect(() => Credentials(username: null, password: "password"),
          throwsAssertionError);
    });

    test("Requires a non-null password", () {
      expect(() => Credentials(username: "username", password: null),
          throwsAssertionError);
    });

    test("Credentials creating properly", () {
      Credentials(username: "username", password: "password");
    });

    test("Credentials toString method", () {
      expect(
        Credentials(username: "12", password: "321").toString(),
        "Credentials(12, •••)",
      );
      expect(
        Credentials(username: "user", password: "password").toString(),
        "Credentials(user, ••••••••)",
      );
      expect(
        Credentials(username: "", password: "").toString(),
        "Credentials(, )",
      );
    });
  });
}
