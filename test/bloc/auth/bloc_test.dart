import 'package:antassistant/bloc/auth/bloc.dart';
import 'package:antassistant/bloc/auth/state.dart';
import 'package:antassistant/data/repository/repository.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/entity/id_entity.dart';
import 'package:bloc_test/bloc_test.dart';
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
          () => AuthBloc(repository: null),
          throwsA(isAssertionError),
        );
      },
    );

    blocTest<AuthBloc, AuthBlocState>(
      "AuthBloc send Unauthenticated state when there is no credentials",
      build: () {
        when(repository.getCredentials()).thenAnswer((_) async => null);
        return AuthBloc(repository: repository);
      },
      expect: [isA<Unauthenticated>()],
    );

    blocTest<AuthBloc, AuthBlocState>(
      "AuthBloc send Unauthenticated state when there is no credentials",
      build: () {
        when(repository.getCredentials()).thenAnswer((_) async => List());
        return AuthBloc(repository: repository);
      },
      expect: [isA<Unauthenticated>()],
    );

    blocTest<AuthBloc, AuthBlocState>(
      "AuthBloc send Authenticated state when there at least one credentials",
      build: () {
        when(repository.getCredentials()).thenAnswer((_) async => List()
          ..add(IDEntity(
            id: 0,
            entity: Credentials(
              username: "",
              password: "",
            ),
          )));
        return AuthBloc(repository: repository);
      },
      expect: [isA<Authenticated>()],
    );
  });
}
