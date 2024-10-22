import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  // Función para obtener el nombre y rol del usuario autenticado
  Future<Map<String, String>> _getUserData() async {
    try {
      // Consulta a Firestore para obtener el usuario autenticado con rol "Supervisor"
      QuerySnapshot<Map<String, dynamic>> supervisorSnapshot =
          await FirebaseFirestore.instance
              .collection('usuarios')
              .where('rol', isEqualTo: 'Supervisor')
              .get();

      if (supervisorSnapshot.docs.isNotEmpty) {
        // Si hay un supervisor autenticado, devuelve su nombre y rol
        var data = supervisorSnapshot.docs.first.data();
        return {
          'userName': data['nombre'],
          'userRole': data['rol'],
        };
      } else {
        // Si no se encontró un supervisor autenticado, devuelve valores por defecto
        return {
          'userName': 'Ingresar',
          'userRole': 'Auxiliar',
        };
      }
    } catch (e) {
      // En caso de error, mostrar los valores predeterminados
      return {
        'userName': 'Ingresar',
        'userRole': 'Auxiliar',
      };
    }
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
      // Utilizamos FutureBuilder para obtener y mostrar dinámicamente los datos del usuario en el drawer
      drawer: FutureBuilder<Map<String, String>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra un loader mientras se obtienen los datos
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // En caso de error, mostrar un Drawer con valores por defecto
            return const CustomDrawer(
              userName: 'Ingresar',
              userRole: 'Auxiliar',
            );
          } else {
            // Si se obtienen los datos correctamente, los mostramos en el drawer
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

class DatosScreen extends StatelessWidget {
  const DatosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.8,
              children: <Widget>[
                _buildDropdownField(
                    'MODALIDAD DE PRODUCCIÓN', ['Normal', 'Otra'], 'Normal'),
                _buildTextField('LOTE'),
                _buildDropdownField('MAQUINISTA', ['Agustin Fernandez', 'Otro'],
                    'Agustin Fernandez'),
                _buildTextField('PARTE'),
                _buildDropdownField('PRODUCTO',
                    ['CRISTAL EC30', 'Otro Producto'], 'CRISTAL EC30'),
                _buildDropdownField(
                    'GRAMAJE', ['20,1 M5 R', 'Otro Gramaje'], '20,1 M5 R'),
                _buildTextField('CICLO PROM'),
                _buildDropdownField(
                    'CAVIDADES HABILITADAS', ['96', 'Otra cantidad'], '96'),
                _buildTextField('PESO PROMEDIO'),
                _buildTextField('PA INICIAL'),
                _buildTextField('PA FINAL'),
                _buildDropdownField('EMPAQUE', ['JAULA GRANDE', 'Otro Empaque'],
                    'JAULA GRANDE'),
                _buildTextField('CANTIDAD'),
                _buildTextField('PESO PROM. EN CONT. NETO'),
                _buildTextField('TOTAL DE CAJAS CONTROLADAS'),
                _buildTextField('SALDOS'),
                _buildTextField('TOTAL DE CAJAS PRODUCIDAS'),
                _buildTextField('CANTIDAD TOTAL PIEZAS'),
                _buildTextField('CANTIDAD TOTAL KG'),
                _buildTextField('CANTIDAD DE PROD. RETENIDO'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('CONFORMIDAD TIEMPO DE ENFRIAMIENTO'),
                    Switch(
                      value: false,
                      onChanged: (bool newValue) {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(
      String label, List<String> options, String defaultValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButton<String>(
          isExpanded: true,
          value: defaultValue,
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {},
        ),
      ],
    );
  }
}

class MateriaPrimaAditivosScreen extends StatelessWidget {
  const MateriaPrimaAditivosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Hola'),
        Wrap(
          children: [Text('Hola'), Text('Hola')],
        )
      ],
    );
  }
}

class DefectosScreen extends StatelessWidget {
  const DefectosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Defectos Screen'));
  }
}

class PesosScreen extends StatelessWidget {
  const PesosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Pesos Screen'));
  }
}

class MonitoreoScreen extends StatelessWidget {
  const MonitoreoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Monitoreo Screen'));
  }
}

class TemperaturaScreen extends StatelessWidget {
  const TemperaturaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Temperatura Screen'));
  }
}
