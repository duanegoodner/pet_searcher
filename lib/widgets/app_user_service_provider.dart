import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_user_service.dart';

class AppUserServiceProvider extends StatelessWidget {
  final Widget child;

  const AppUserServiceProvider({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = Provider.of<fb_auth.FirebaseAuth>(context);
    return Provider(
      create: (context) => AppUserService(firebaseAuth: firebaseAuth),
      child: child,
    );
  }
}
