part of 'signup_cubit.dart';

enum SignupStatus {
  initial,
  submitting,
  success,
  error,
}

class SignupState extends Equatable {
  const SignupState({
    required this.signupStatus,
    required this.error,
  });
  factory SignupState.initial() {
    return const SignupState(
      signupStatus: SignupStatus.initial,
      error: CustomError(),
    );
  }
  final SignupStatus signupStatus;
  final CustomError error;

  @override
  List<Object> get props => [signupStatus, error];

  @override
  String toString() =>
      'SignupState(signupStatus: $signupStatus, error: $error)';

  SignupState copyWith({
    SignupStatus? signupStatus,
    CustomError? error,
  }) {
    return SignupState(
      signupStatus: signupStatus ?? this.signupStatus,
      error: error ?? this.error,
    );
  }
}
