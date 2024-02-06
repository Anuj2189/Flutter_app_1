import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_service.dart';
import 'package:flutter_application_1/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/auth/bloc/auth_event.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
            backgroundColor: Colors.blue[200],
        ),
        body: Column(
          children: [
            const Text(
                'We have sent you an email verification,Please open it to verify your account'),
            const Text(
                "If you haven't received a verification email yet , press the button below"),
            TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventSendEmailVerification(),
                      );
                },
                child: const Text('Send Email Verification')),
            TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventLogOut(),
                      );
                },
                child: const Text('Restart'))
          ],
        ));
  }
}
