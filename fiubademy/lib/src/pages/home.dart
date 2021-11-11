import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import '../services/auth.dart';
import 'package:provider/provider.dart';
import 'package:fiubademy/src/pages/profile.dart';
import 'package:fiubademy/src/services/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _locationEnabled = Geolocator.isLocationServiceEnabled();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _locationEnabled,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.data!) {
              return Container();
            }
            return Scaffold(
              drawer: _buildDrawer(context),
              body: FloatingSearchAppBar(
                body: _buildExpandableBody(context),
                title: const Text('Ubademy'),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}

Widget _buildExpandableBody(BuildContext context) {
  return Container();
}

Widget _buildDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text(Provider.of<User>(context).username),
                  accountEmail: Text(Provider.of<User>(context).email)),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('My Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const ProfilePage();
                    }),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.school),
                title: const Text('My Courses'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.supervisor_account),
                title: const Text('My Collaborations'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Favourites'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Messages'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Provider.of<Auth>(context, listen: false).deleteAuth();
          },
          leading: Icon(Icons.logout, color: Colors.red[700]),
          title: Text(
            'Log Out',
            style: TextStyle(
              color: Colors.red[700],
            ),
          ),
        ),
      ],
    ),
  );
}
