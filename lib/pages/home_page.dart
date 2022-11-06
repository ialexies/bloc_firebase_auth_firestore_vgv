import 'package:bloc_firebase_auth_firestore_vgv/app/modules/auth/auth_bloc.dart';
import 'package:bloc_firebase_auth_firestore_vgv/app/modules/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = '/home';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ProfilePage();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.account_circle),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/bloc_logo_full.png',
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              const SizedBox(height: 20),
              const Text(
                'Bloc is an awesome\nstate management library\nfor flutter!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
