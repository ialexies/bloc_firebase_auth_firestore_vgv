// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:bloc_firebase_auth_firestore_vgv/app/modules/auth/auth_bloc.dart';
import 'package:bloc_firebase_auth_firestore_vgv/app/modules/profile/bloc/profile_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  void _getProfile() {
    final uid = context.read<AuthBloc>().state.user!.uid;
    context.read<ProfileCubit>().getProfile(uid: uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(SignoutRequestedEvent());
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // context.read<AuthBloc>().;
          // context.read<AuthBloc>().add(SignoutRequestedEvent());

          // context.read<AuthBloc>().add(UpdatePhotoUrlEvent());

          // Future<void> updateProfilePhoto(XFile? img) async {
          // print(state.user.profileImage);
          // state.user.profileImage = img?.path ?? '';
          // }
          // if (state.profileStatus == ProfileStatus.error) {
          //   //TODO(ialexies): add error for this eception
          //   log('error in profile status');
          //   // errorDialog(context, state.error);
          // }
        },
        builder: (context, state) {
          if (state.profileStatus == ProfileStatus.initial) {
            return Container();
          } else if (state.profileStatus == ProfileStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.profileStatus == ProfileStatus.error) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/error.png',
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'Ooops!\nTry again',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: PhotoBuilder(state),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    children: [
                      Text(
                        toBeginningOfSentenceCase(state.user.firstName)
                            .toString(),
                        style: TextStyle(
                          fontSize: 140.sp,
                        ),
                      ),
                      Text(
                        state.user.email,
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        toBeginningOfSentenceCase(state.user.id).toString(),
                        style: TextStyle(
                          fontSize: 26.sp,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 30),
                      UserDataBuilder(state),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class UserDataBuilder extends StatelessWidget {
  const UserDataBuilder(this.state, {super.key});
  final ProfileState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserDataRowBuilder(
          state,
          Icons.star,
          Text(toBeginningOfSentenceCase(state.user.rank).toString()),
        ),
        UserDataRowBuilder(
          state,
          Icons.mail,
          state.user.lastName == null
              ? Text(
                  'Last Name',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w300,
                  ),
                )
              : Text(
                  toBeginningOfSentenceCase(state.user.lastName)!,
                ),
          editable: true,
        ),
        UserDataRowBuilder(
          state,
          Icons.mail,
          state.user.age == null
              ? Text(
                  'Last Name',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w300,
                  ),
                )
              : Text(
                  toBeginningOfSentenceCase(state.user.age)!,
                ),
          editable: true,
        ),
        UserDataRowBuilder(
          state,
          Icons.add_chart_sharp,
          Text(
              '${toBeginningOfSentenceCase(state.user.point.toString())} Points'),
        ),
      ],
    );
  }
}

class UserDataRowBuilder extends StatelessWidget {
  const UserDataRowBuilder(
    this.state,
    this._name,
    this._val, {
    this.editable,
    super.key,
  });
  final ProfileState state;
  final IconData _name;
  final Widget _val;
  final bool? editable;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(_name),
            const SizedBox(width: 10),
            _val,
            const Spacer(),
            if (editable == null)
              const SizedBox.shrink()
            else
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  size: 20,
                  color: Colors.grey,
                ),
                splashColor: Colors.amberAccent.withOpacity(.5),
                splashRadius: 26,
              ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

class PhotoBuilder extends StatelessWidget {
  const PhotoBuilder(this.state, {super.key});

  final ProfileState state;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(300),
        child: Stack(
          children: [
            ExtendedImage.network(
              state.user.profileImage,
              cache: false,
              loadStateChanged: (ExtendedImageState state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return const LinearProgressIndicator();

                  case LoadState.completed:
                    return ExtendedRawImage(
                      image: state.extendedImageInfo?.image,
                    );

                  case LoadState.failed:
                    return GestureDetector(
                      child: Stack(
                        fit: StackFit.expand,
                        children: const <Widget>[
                          Text('No Image'),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Text(
                              'load image failed, click to reload',
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        state.reLoadImage();
                      },
                    );
                }
              },
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black.withOpacity(.5),
                width: 600.w,
                height: 150.w,
                child: TextButton(
                  onPressed: () async {
                    XFile? imgFile = XFile('');
                    try {
                      imgFile = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                        preferredCameraDevice: CameraDevice.front,
                      );
                    } catch (e) {}

                    if (imgFile == null) return;

                    // context.read<AuthBloc>().add(
                    //       UpdatePhotoUrlEvent(
                    //         photoUrl: imgFile.path,
                    //       ),
                    //     );

                    // await context
                    //     .read<ProfileCubit>()
                    //     .updateProfilePhoto(await imgFile);
                  },
                  child: const Text(
                    'Edit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
