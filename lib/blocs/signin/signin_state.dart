part of 'signin_cubit.dart';

// part 'signin_state.freezed.dart';
enum SigninStatus { initial, submitting, success, error }

@freezed
class SigninState with _$SigninState {
  const factory SigninState({
    required SigninStatus signinStatus,
    required FirebaseAuthApiFailure error,
  }) = _SigninState;

  factory SigninState.initial() {
    return const SigninState(
      signinStatus: SigninStatus.initial,
      error: FirebaseAuthApiFailure(),
    );
  }
}
