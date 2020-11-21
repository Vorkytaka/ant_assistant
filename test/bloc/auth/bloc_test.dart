import 'package:antassistant/bloc/auth/bloc.dart';
import 'package:antassistant/data/repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRepository extends Mock implements Repository {}

void main() {
  Repository repository;

  setUp(() {
    repository = MockRepository();
  });

  group("AuthBloc test", () {
    test(
      "AuthBloc throw error if repository is null",
      () {
        expect(
          () => AuthBloc(null),
          throwsA(isAssertionError),
        );
      },
    );
  });
}
