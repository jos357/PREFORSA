import 'package:flutter/material.dart';
import 'popup_form.dart'; // Importamos el archivo del formulario
import 'auxiliary_list.dart'; // Importamos la lista de auxiliares

class CustomDrawer extends StatefulWidget {
  final String userName;
  final String userRole;

  const CustomDrawer({
    super.key,
    required this.userName,
    required this.userRole,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late String currentUserName;
  late String currentUserRole;

  @override
  void initState() {
    super.initState();
    // Inicializamos con los valores que vienen del widget
    currentUserName = widget.userName;
    currentUserRole = widget.userRole;
  }

  // Función para actualizar los valores del usuario
  void updateUser(String newUserName, String newUserRole) {
    setState(() {
      currentUserName = newUserName;
      currentUserRole = newUserRole;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(currentUserName),
            accountEmail: Text(currentUserRole),
            currentAccountPicture: CircleAvatar(
              child: Text(
                currentUserName[0], // Inicial del nombre del usuario
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
                    ).then((result) {
                      // Supongamos que después de verificar, obtenemos el nombre y rol actualizados
                      if (result != null) {
                        updateUser(result['userName'], 'Supervisor');
                      }
                    });
                  } else if (value == 'Verificar Auxiliar') {
                    // Si seleccionamos "Verificar Auxiliar", mostramos la lista de nombres
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AuxiliaryList(); // Llamamos a la lista de nombres
                      },
                    ).then((result) {
                      if (result != null) {
                        updateUser(result['userName'], 'Auxiliar');
                      }
                    });
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
          // Condición para mostrar la opción de "Configuraciones"
          if (currentUserRole == 'Supervisor')
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuraciones'),
              onTap: () {
                Navigator.pop(context);
                // Navegar a la pantalla de configuraciones
              },
            ),
          // Más opciones...
        ],
      ),
    );
  }
}
