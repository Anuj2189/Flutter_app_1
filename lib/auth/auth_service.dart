import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/auth/auth_provider.dart' as AuthProvider;
import 'package:flutter_application_1/auth/auth_user.dart';
import 'package:flutter_application_1/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider.AuthProvider{
final AuthProvider.AuthProvider provider;
const AuthService(this.provider);

factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser({required String email, required String password}) => provider.createUser(email: email, password: password);

  @override
  
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({required String email, required String password})=>provider.logIn(email: email, password: password);

  @override
  Future<void> logOut()=>provider.logOut();

  @override
  Future<void> sendEmailVerification()=>provider.sendEmailVerification();
  
  @override
  Future<void> initialize() => provider.initialize();
  
  @override
  Future<void> sendPasswordReset({required String toEmail}) => provider.sendPasswordReset(toEmail: toEmail);
}