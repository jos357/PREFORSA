import 'package:flutter/material.dart';

class ScreenPreformaIPS extends StatefulWidget {
  const ScreenPreformaIPS({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScreenPreformaIPSState createState() => _ScreenPreformaIPSState();
}

class _ScreenPreformaIPSState extends State<ScreenPreformaIPS> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Datos Screen'),
    Text('Materia Prima y Aditivos Screen'),
    Text('Defectos Screen'),
    Text('Pesos Screen'),
    Text('Monitoreo Screen'),
    Text('Temperatura Screen'),
  ];

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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.description), // Icono para "Datos"
            label: 'Datos',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.shopping_cart), // Icono para "Materia Prima y Aditivos"
            label: 'MP y Aditivos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search), // Icono para "Defectos"
            label: 'Defectos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_weight), // Icono para "Pesos"
            label: 'Pesos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics), // Icono para "Monitoreo"
            label: 'Monitoreo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat), // Icono para "Temperatura"
            label: 'Temperatura',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black, // Color para el ícono seleccionado
        unselectedItemColor:
            Colors.black, // Color para los íconos no seleccionados
        onTap: _onItemTapped,
      ),
    );
  }
}
