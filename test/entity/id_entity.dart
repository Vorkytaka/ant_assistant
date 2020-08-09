import 'package:antassistant/entity/id_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("IDEntity", () {
    test("Requires a non-null id", () {
      expect(() => IDEntity(id: null, entity: "entity"), throwsAssertionError);
    });

    test("Requires a non-null entity", () {
      expect(() => IDEntity(id: 1, entity: null), throwsAssertionError);
    });
  });
}
