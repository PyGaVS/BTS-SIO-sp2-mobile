import 'package:flutter/material.dart';
import 'package:selenium_chat/config/app_settings.dart';
import 'package:selenium_chat/model/auth.dart';

class NavDrawableWidget extends StatelessWidget {
  const NavDrawableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: AppSettings.BG_COLOR,
        child: ListView(
          //Important: Remove any padding from the ListView
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              padding: EdgeInsets.fromLTRB(20, 15, 5, 0),
              decoration: BoxDecoration(color: Colors.black38),
              child: Text('Selenium', style: TextStyle(color: Colors.white, fontSize: 22)),
            ),

            //items as ListTile
            ListTile(
              leading: const Icon(Icons.dashboard_sharp, color: Colors.white),
              title: const Text('home', style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              )),
              onTap: () => { Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false) },
            ),
          ],
        )
    );
  }
}
