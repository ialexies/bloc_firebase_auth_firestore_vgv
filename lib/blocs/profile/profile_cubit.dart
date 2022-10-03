import 'package:bloc/bloc.dart';
import 'package:bloc_firebase_auth_firestore_vgv/models/custom_error.dart';
import 'package:authentication_repository/authentication_repository.dart'
    as my_auth_repo;

import 'package:bloc_firebase_auth_firestore_vgv/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.profileRepository,
  }) : super(ProfileState.initial());
  final ProfileRepository profileRepository;

  Future<void> getProfile({required String uid}) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    try {
      final user = await profileRepository.getProfile(uid: uid);
      emit(
        state.copyWith(
          profileStatus: ProfileStatus.loaded,
          user: user,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          profileStatus: ProfileStatus.error,
          error: e,
        ),
      );
    }
  }
}
