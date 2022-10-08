import 'package:bloc_firebase_auth_firestore_vgv/blocs/signin/signin_cubit.dart';
import 'package:bloc_firebase_auth_firestore_vgv/pages/signup_page.dart';
import 'package:bloc_firebase_auth_firestore_vgv/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});
  static const String routeName = '/signin';

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _email, _password;

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    context.read<SigninCubit>().signin(email: _email!, password: _password!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<SigninCubit, SigninState>(
          listener: (context, state) {
            if (state.signinStatus == SigninStatus.error) {
              errorDialog(context, state.error.message, state.error.code,
                  state.error.plugin);
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Image.asset(
                          'assets/images/flutter_logo.png',
                          width: 250,
                          height: 250,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email required';
                            }
                            if (!isEmail(value.trim())) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _email = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Password required';
                            }
                            if (value.trim().length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _password = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed:
                              state.signinStatus == SigninStatus.submitting
                                  ? null
                                  : _submit,
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: Text(
                            state.signinStatus == SigninStatus.submitting
                                ? 'Loading...'
                                : 'Sign In',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed:
                              state.signinStatus == SigninStatus.submitting
                                  ? null
                                  : () {
                                      Navigator.pushNamed(
                                        context,
                                        SignupPage.routeName,
                                      );
                                    },
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          child: const Text('Not a member? Sign Up!'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
