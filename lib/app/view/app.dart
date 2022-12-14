// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_firebase_auth_firestore_vgv/app/modules/auth/auth_bloc.dart';
import 'package:bloc_firebase_auth_firestore_vgv/app/modules/profile/bloc/profile_cubit.dart';
import 'package:bloc_firebase_auth_firestore_vgv/app/modules/signin/bloc/signin_cubit.dart';
import 'package:bloc_firebase_auth_firestore_vgv/app/modules/signin/signin_page.dart';
import 'package:bloc_firebase_auth_firestore_vgv/app/modules/signup/signup_cubit.dart';
import 'package:bloc_firebase_auth_firestore_vgv/app/modules/signup/signup_page.dart';
import 'package:bloc_firebase_auth_firestore_vgv/pages/home_page.dart';
import 'package:bloc_firebase_auth_firestore_vgv/pages/splash_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SigninCubit>(
            create: (context) => SigninCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(
              profileRepository: context.read<ProfileRepository>(),
            ),
          ),
        ],
        child: ScreenUtilInit(
            designSize: const Size(1080, 2460),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, _) {
              return MaterialApp(
                title: 'Firebase Auth ${_.toString()}',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: const SplashPage(),
                routes: {
                  SignupPage.routeName: (context) => const SignupPage(),
                  SigninPage.routeName: (context) => const SigninPage(),
                  HomePage.routeName: (context) => const HomePage(),
                },
              );
            }),
      ),
    );
  }
}
