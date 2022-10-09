import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_firebase_auth_firestore_vgv/models/custom_error.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'signup_state.dart';
part 'signup_cubit.freezed.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({
    required this.authRepository,
  }) :
        // super(SignupState.initial());
        super(
          SignupState(
            error: CustomError.initial(),
            signupStatus: SignupStatus.initial,
          ),
        );
  final AuthRepository authRepository;

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(signupStatus: SignupStatus.submitting));

    try {
      await authRepository.signup(
        name: name,
        email: email,
        password: password,
      );
      emit(state.copyWith(signupStatus: SignupStatus.success));
    } on CustomError catch (e) {
      emit(state.copyWith(signupStatus: SignupStatus.error, error: e));
    }
  }
}
