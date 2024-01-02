import 'package:firebase_dart/auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body : Column(
        children: [const Text('Please verify your email address'),
        TextButton(onPressed:() async {
          final user = FirebaseAuth.instance.currentUser;
          await user?.sendEmailVerification();
           
        }, child: const Text('Send Email Verification'))],
        
      )
    );
  }
}
