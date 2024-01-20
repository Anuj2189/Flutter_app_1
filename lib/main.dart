


import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_service.dart';



import 'package:flutter_application_1/routes.dart';

import 'package:flutter_application_1/views/login_view.dart';
import 'package:flutter_application_1/views/updated_notes_view.dart';
import 'package:flutter_application_1/views/notes_view.dart';
import 'package:flutter_application_1/views/register_view.dart';
import 'package:flutter_application_1/views/verify_email_view.dart';
import 'dart:developer';

import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const HomePage(),
    routes: {
      loginRoute:(context) => const LoginView(),
      registerRoute:(context) => const RegisterView(),
      notesRoute:(context) => const NotesView(),
      verifyEmailRoute:(context) => const VerifyEmailView(),
      newNoteRoute:(context) => const NewNoteView()
    },
  ));
}
enum MenuAction{
  logout
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if(user!=null){
              if(user.isEmailVerified){
              return const NotesView();}
            else{
              return const VerifyEmailView();
            }}
            else{
              return const LoginView();
            }
      
            default:
              return CircularProgressIndicator();
          }
        },
      );
    
  }
}
