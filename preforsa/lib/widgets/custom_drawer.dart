// custom_drawer.dart
import 'package:flutter/material.dart';
import 'popup_form.dart'; // Importamos el archivo del formulario
import 'auxiliary_list.dart'; // Importamos la lista de auxiliares

class CustomDrawer extends StatelessWidget {
  final String userName;
  final String userRole;

  const CustomDrawer({
    super.key,
    required this.userName,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: Text(userRole),
            currentAccountPicture: CircleAvatar(
              child: Text(
                userName[0], // Inicial del nombre del usuario
                style: const TextStyle(fontSize: 40.0),
              ),
            ),
            // Botón de tres puntos en la cabecera
            otherAccountsPictures: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert), // Icono de tres puntos
                onSelected: (String value) {
                  if (value == 'Verificar Supervisor') {
                    // Si seleccionamos "Verificar Supervisor", mostramos el formulario
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const PopupForm(); // Llamamos al widget del formulario
                      },
                    );
                  } else if (value == 'Verificar Auxiliar') {
                    // Si seleccionamos "Verificar Auxiliar", mostramos la lista de nombres
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AuxiliaryList(); // Llamamos a la lista de nombres
                      },
                    );
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem<String>(
                      value: 'Verificar Supervisor',
                      child: Text('Verificar Supervisor'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Verificar Auxiliar',
                      child: Text('Verificar Auxiliar'),
                    ),
                  ];
                },
              ),
            ],
          ),
          // Opciones del Drawer
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Yizumi'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Preformas IPS'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('CCM'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('COLORACAP'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Prefomas I5'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Configuraciones'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          // Más opciones...
        ],
      ),
    );
  }
}
