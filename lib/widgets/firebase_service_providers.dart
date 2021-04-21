import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebaseServiceProviders extends StatelessWidget {
  final Widget child;

  const FirebaseServiceProviders({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(
        create: (_) => fb_auth.FirebaseAuth.instance,
      ),
      Provider(
        create: (_) => cf.FirebaseFirestore.instance,
      ),
    ], child: child);
  }
}
