import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/use_case/register_user_usecase.dart';
import '../../../domain/use_case/upload_image_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final CreateUserUsecase _createUserUsecase;
  final UploadImageUseCase _uploadImageUseCase;

  RegisterBloc({
    required CreateUserUsecase createUserUsecase,
    required UploadImageUseCase uploadImageUseCase,
  })  : _createUserUsecase = createUserUsecase,
        _uploadImageUseCase = uploadImageUseCase,
        super(RegisterState.initial()) {
    on<RegisterUser>(_onRegisterUser);
    on<LoadImage>(_onLoadImage);
  }

  void _onLoadImage(
    LoadImage event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isImageLoading: true));
    final result = await _uploadImageUseCase.call(
      UploadImageParams(
        file: event.file,
      ),
    );
    emit(state.copyWith(
        isImageLoading: false,
        isImageSuccess: true,
        imageName: event.file.path));

    // result.fold(
    //     (l) =>
    //         emit(state.copyWith(isImageLoading: false, isImageSuccess: false)),
    //     (r) {
    //   emit(state.copyWith(
    //       isImageLoading: false, isImageSuccess: true, imageName: r));
    // });
  }

  Future<void> _onRegisterUser(
      RegisterUser event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isLoading: true));

    final params = CreateUserParams(event.file,
      name: event.name,
      phone: event.phone,
      email: event.email,
      password: event.password,
      photo: ""
    );

    print("Image File --> ${event.file}");
    final result = await _createUserUsecase.call(params);

    result.fold(
        (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (user) => emit(state.copyWith(isLoading: false, isSuccess: true)));
  }
}
