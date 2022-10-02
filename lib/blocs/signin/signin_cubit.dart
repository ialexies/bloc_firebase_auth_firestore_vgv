import 'package:bloc/bloc.dart';
import 'package:bloc_firebase_auth_firestore_vgv/models/custom_error.dart';
import 'package:bloc_firebase_auth_firestore_vgv/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit({required this.authRepository}) : super(SigninState.initial());
  final AuthRepository authRepository;

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(signinStatus: SigninStatus.submitting));

    try {
      await authRepository.signin(email: email, password: password);

      emit(state.copyWith(signinStatus: SigninStatus.success));
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          signinStatus: SigninStatus.error,
          error: e,
        ),
      );
    }
  }
}
