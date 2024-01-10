import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dart/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/routes.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body : Column(
        children: [ const Text('We have sent you an email verification,Please open it to verify your account'),
          const Text("If you haven't received a verification email yet , press the button below"),
        TextButton(onPressed:() async {
          final user = FirebaseAuth.instance.currentUser;
          await user?.sendEmailVerification();
           
        }, child: const Text('Send Email Verification')),
        TextButton(onPressed:() {
          Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
        }, child:const Text('Restart'))
        ],
             
      )
    );
      }
      
    
  }

