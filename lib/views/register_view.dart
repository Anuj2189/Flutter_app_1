import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_exceptions.dart';

import 'package:flutter_application_1/auth/auth_service.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:flutter_application_1/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
   late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  
  @override
    Widget build(BuildContext context) {
     
      
    return Scaffold(
      appBar: AppBar(title: const Text('Register'),
      backgroundColor: Colors.blue[200],),
      body: Column(
                  children: [
                    TextField(
                      controller: _email,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                          hintText: "Enter your email here"),
                    ),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration:
                          const InputDecoration(hintText: "Enter password"),
                    ),
                    TextButton(
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;
                        try{ await AuthService.firebase().createUser(email: email, password: password);
                               AuthService.firebase().sendEmailVerification();
                              Navigator.of(context).pushNamed(verifyEmailRoute);    
                        } on WeakPasswordAuthException{
                          showErrorDialog(context, 'Weak Password');
                        }
                        on EmailAlreadyInUseAuthException{
                          showErrorDialog(context, 'Email is already in use');
                        }
                        on InvalidEmailAuthException{
                          showErrorDialog(context, 'This is an invalid Email Address');
                        }
                         on GenericAuthException {
                          showErrorDialog(context, 'Unable to Register');
                        }
                       
                      },
                      child: const Text('Register'),
                    ),
                    TextButton(onPressed:() {
                       Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
                    }, child: const Text('Already registered? Login Here!'))
                  ],
                ),
    );
    }
}


