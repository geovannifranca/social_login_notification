import 'package:flutter/material.dart';
import 'package:social_login_notification/widget/custom_drawer.dart';

class MessasgesScreen extends StatelessWidget {
  const MessasgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const CustomDrawer(),
      body: const Center(child: Text('Página de menssagem')),
    );
  }
}
