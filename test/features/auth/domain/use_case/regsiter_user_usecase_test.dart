import 'package:beauty_booking_app/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:beauty_booking_app/core/error/failure.dart';
import 'package:beauty_booking_app/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'auth_repo.mock.dart';

void main() {
  late CreateUserUsecase useCase;
  late MockAuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    useCase = CreateUserUsecase(userRepository: repository);
  });

  const UserParams = CreateUserParams(
    name: 'name',
    email: 'email',
    phone: 'phone',
    username: 'username',
    password: 'password',
    photo: 'photo',
  );

  final authEntity = UserEntity(
    id: null,
    name: UserParams.name,
    username: UserParams.username,
    phone: UserParams.photo,
    email: UserParams.email,
    password: UserParams.password,
    photo: UserParams.photo,
  );

  test('should call registerUser in the repository with correct params',
      () async {
    // Arrange
    when(() => repository.createUser(authEntity))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await useCase(UserParams);

    // Assert
    expect(result, const Right(null));
    verify(() => repository.createUser(authEntity)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return Left(Failure) when registration fails', () async {
    // Arrange
    final failure = ApiFailure(message: 'Registration failed');
    when(() => repository.createUser(authEntity))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase(UserParams);

    // Assert
    expect(result, Left(failure));
    verify(() => repository.createUser(authEntity)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
