import 'package:flutter/material.dart';
import 'package:project_pariwisata_new/page/home_admin_page.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';

import 'home_page.dart';
import 'login.dart';
import 'navigation_page.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    if (user == null) {
      return LoginScreen();
    } else if (user.role == 'Customers') {
      return NavigationPage();
    } else {
      return PariwisataScreen();
    }
  }
}
