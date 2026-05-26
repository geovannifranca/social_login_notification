import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:social_login_notification/screen/messasges_screen.dart';
import 'package:social_login_notification/screen/profile_screen.dart';
import 'package:social_login_notification/screen/settigns_screen.dart';
import 'package:social_login_notification/store/custom_drawer_store.dart';
import 'package:social_login_notification/store/login_store.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final _loginStore = GetIt.I.get<LoginStore>();
  final _drawerStore = GetIt.I.get<CustomDrawerStore>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFFECE2D3)),
            child: Observer(
              builder: (context) {
                return Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        _loginStore.currentUser?.photoURL ??
                            'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png',
                      ),
                      radius: 40,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      _loginStore.currentUser?.displayName ??
                          'Usuário não logado',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            selected: _drawerStore.selectedMenu == 1,
            onTap: () {
              _drawerStore.setSelectedMenu(1);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favoritos'),
            selected: _drawerStore.selectedMenu == 2,
            onTap: () => _drawerStore.setSelectedMenu(2),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Menssagem'),
            selected: _drawerStore.selectedMenu == 3,
            onTap: () {
              _drawerStore.setSelectedMenu(3);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MessasgesScreen(),
                ),
              );
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text('Aplicativo', style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuração'),
            selected: _drawerStore.selectedMenu == 4,
            onTap: () {
              _drawerStore.setSelectedMenu(4);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettignsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Sobre'),
            selected: _drawerStore.selectedMenu == 5,
            onTap: () => _drawerStore.setSelectedMenu(5),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () {},
          ),
          const Spacer(),
          const SafeArea(child: Center(child: Text('Versão 1.0.0'))),
        ],
      ),
    );
  }
}
