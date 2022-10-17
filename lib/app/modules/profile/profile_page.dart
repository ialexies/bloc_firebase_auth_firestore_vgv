import 'dart:developer';

import 'package:bloc_firebase_auth_firestore_vgv/app/modules/auth/auth_bloc.dart';
import 'package:bloc_firebase_auth_firestore_vgv/app/modules/profile/bloc/profile_cubit.dart';
import 'package:extended_image/extended_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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
        title: const Text('Profile'),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.profileStatus == ProfileStatus.error) {
            //TODO(ialexies): add error for this eception
            log('error in profile status');
            // errorDialog(context, state.error);
          }
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
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FadeInImage.assetNetwork(
                //   placeholder: 'assets/images/loading.gif',
                //   image: state.user.profileImage,
                //   width: double.infinity,
                //   fit: BoxFit.cover,
                // ),
                Center(
                  child: SizedBox(
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
                                onPressed: () => print('sdsdsd'),
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
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '-id: ${state.user.id}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '- name: ${state.user.name}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '- email: ${state.user.email}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '- point: ${state.user.point}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '- rank: ${state.user.rank}',
                        style: const TextStyle(fontSize: 18),
                      ),
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
