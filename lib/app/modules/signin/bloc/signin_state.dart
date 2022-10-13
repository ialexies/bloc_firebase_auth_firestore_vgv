part of 'signin_cubit.dart';

// part 'signin_state.freezed.dart';
enum SigninStatus { initial, submitting, success, error }

@freezed
class SigninState with _$SigninState {
  const factory SigninState({
    @Default(SigninStatus.initial) SigninStatus? signinStatus,
    @Default(FirebaseAuthApiFailure()) FirebaseAuthApiFailure error,
  }) = _SigninState;
}
