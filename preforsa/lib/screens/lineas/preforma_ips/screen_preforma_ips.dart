import 'package:flutter/material.dart';
import 'package:preforsa/screens/lineas/preforma_ips/screens_form/datos_screen.dart';
import 'package:preforsa/screens/lineas/preforma_ips/screens_form/defectos_screen.dart';
import 'package:preforsa/screens/lineas/preforma_ips/screens_form/materia_prima_aditivos_screen.dart';
import 'package:preforsa/screens/lineas/preforma_ips/screens_form/monitoreo_screen.dart';
import 'package:preforsa/screens/lineas/preforma_ips/screens_form/pesos_screen.dart';
import 'package:preforsa/screens/lineas/preforma_ips/screens_form/temperatura_screen.dart';
import 'package:preforsa/widgets/custom_drawer.dart';

class ScreenPreformaIPS extends StatefulWidget {
  const ScreenPreformaIPS({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScreenPreformaIPSState createState() => _ScreenPreformaIPSState();
}

class _ScreenPreformaIPSState extends State<ScreenPreformaIPS> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    DatosScreen(),
    MateriaPrimaAditivosScreen(),
    DefectosScreen(),
    PesosScreen(),
    MonitoreoScreen(),
    TemperaturaScreen(),
  ];

  // Esta función ahora devuelve datos estáticos
  Future<Map<String, String>> _getUserData() async {
    // Simulación de obtener datos de un usuario
    return {
      'userName': 'Ingresar',
      'userRole': 'Auxiliar',
    };
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preforma IPS'),
      ),
      drawer: FutureBuilder<Map<String, String>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const CustomDrawer(
              userName: 'Ingresar',
              userRole: 'Auxiliar',
            );
          } else {
            var userData = snapshot.data!;
            return CustomDrawer(
              userName: userData['userName']!,
              userRole: userData['userRole']!,
            );
          }
        },
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Datos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'MP y Aditivos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Defectos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_weight),
            label: 'Pesos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Monitoreo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat),
            label: 'Temperatura',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
