import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/theme_provider.dart';
import 'package:provider/provider.dart';
import '../screens/login_screen.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              "Daily Youth",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SwitchListTile(
            title: Text("Dark Theme"),
            value: themeProvider.themeMode == ThemeMode.dark,
            onChanged: themeProvider.toggleTheme,
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}