import 'package:flutter/material.dart';
import 'package:flutter_application_1/dialog/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context){
  return showGenericDialog<bool>(context: context, title: 'LogOut', content: 'Are you sure you want to log out?', optionsBuilder:() =>{
    'Cancel':false,
    'Log Out':true,
  },).then((value) => value ?? false);
}