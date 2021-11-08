import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      body: FloatingSearchAppBar(
        body: buildExpandableBody(context),
        title: Text('Ubademy'),
      ),
    );
  }
}

Widget buildExpandableBody(BuildContext context) {
  return Container(
      color: Colors.white,
      child: ElevatedButton(
        onPressed: () {
          Provider.of<Auth>(context, listen: false).deleteToken();
        },
        child: Text('Erase Token'),
      ));
}

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              const UserAccountsDrawerHeader(
                  accountName: Text('Santiago Czop'),
                  accountEmail: Text('sczop@fi.uba.ar')),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('My Profile'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.school),
                title: Text('My Courses'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.supervisor_account),
                title: Text('My Collaborations'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
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
            Provider.of<Auth>(context, listen: false).deleteToken();
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
