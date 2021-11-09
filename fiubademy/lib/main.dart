import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fiubademy/src/pages/login.dart';
import 'package:fiubademy/src/pages/home.dart';
import 'package:fiubademy/src/services/auth.dart';
import 'package:fiubademy/src/services/user.dart';

void main() {
  runApp(const FiubademyApp());
}

class FiubademyApp extends StatelessWidget {
  const FiubademyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, User>(
            create: (context) => User(),
            update: (context, auth, user) {
              if (user == null) throw ArgumentError.notNull('user');
              user.userID = auth.userID;
              return user;
            },
          ),
        ],
        builder: (context, child) {
          return MaterialApp(
            title: 'Ubademy',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Provider.of<Auth>(context).userToken == null
                ? const LogInPage()
                : const HomePage(),
          );
        });
  }
}
