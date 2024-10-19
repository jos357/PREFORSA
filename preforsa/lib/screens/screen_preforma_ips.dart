import 'package:flutter/material.dart';

class ScreenPreformaIPS extends StatefulWidget {
  const ScreenPreformaIPS({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScreenPreformaIPSState createState() => _ScreenPreformaIPSState();
}

class _ScreenPreformaIPSState extends State<ScreenPreformaIPS> {
  int _selectedIndex = 0;

  // Lista de los widgets para cada pantalla
  static const List<Widget> _widgetOptions = <Widget>[
    DatosScreen(),
    MateriaPrimaAditivosScreen(),
    DefectosScreen(),
    PesosScreen(),
    MonitoreoScreen(),
    TemperaturaScreen(),
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
            icon: Icon(Icons.shopping_cart), // Icono para "MP y Aditivos"
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

// Pantalla de "Datos"
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
              crossAxisCount: 2, // Cantidad de columnas
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio:
                  1.5, // Proporción para ajustar el tamaño de los campos
              children: <Widget>[
                // Modalidad de Producción
                _buildDropdownField(
                    'MODALIDAD DE PRODUCCIÓN', ['Normal', 'Otra'], 'Normal'),
                // Lote
                _buildTextField('LOTE'),
                // Maquinista
                _buildDropdownField('MAQUINISTA', ['Agustin Fernandez', 'Otro'],
                    'Agustin Fernandez'),
                // Parte
                _buildTextField('PARTE'),
                // Producto
                _buildDropdownField('PRODUCTO',
                    ['CRISTAL EC30', 'Otro Producto'], 'CRISTAL EC30'),
                // Gramaje
                _buildDropdownField(
                    'GRAMAJE', ['20,1 M5 R', 'Otro Gramaje'], '20,1 M5 R'),
                // Ciclo Prom
                _buildTextField('CICLO PROM'),
                // Cavidades Habilitadas
                _buildDropdownField(
                    'CAVIDADES HABILITADAS', ['96', 'Otra cantidad'], '96'),
                // Peso Promedio
                _buildTextField('PESO PROMEDIO'),
                // PA Inicial
                _buildTextField('PA INICIAL'),
                // PA Final
                _buildTextField('PA FINAL'),
                // Empaque
                _buildDropdownField('EMPAQUE', ['JAULA GRANDE', 'Otro Empaque'],
                    'JAULA GRANDE'),
                // Cantidad
                _buildTextField('CANTIDAD'),
                // Peso Prom. en Cont. Neto
                _buildTextField('PESO PROM. EN CONT. NETO'),
                // Total de Cajas Controladas
                _buildTextField('TOTAL DE CAJAS CONTROLADAS'),
                // Saldos
                _buildTextField('SALDOS'),
                // Total de Cajas Producidas
                _buildTextField('TOTAL DE CAJAS PRODUCIDAS'),
                // Cantidad Total Piezas
                _buildTextField('CANTIDAD TOTAL PIEZAS'),
                // Cantidad Total KG
                _buildTextField('CANTIDAD TOTAL KG'),
                // Cantidad de Prod. Retenido
                _buildTextField('CANTIDAD DE PROD. RETENIDO'),
                // Conformidad Tiempo de Enfriamiento (Switch)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('CONFORMIDAD TIEMPO DE ENFRIAMIENTO'),
                    Switch(
                      value: false,
                      onChanged: (bool newValue) {
                        // Aquí puedes manejar el cambio de valor del switch
                      },
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

  // Método para construir campos de texto
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

  // Método para construir campos desplegables (Dropdown)
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

// Pantalla de "Materia Prima y Aditivos"
class MateriaPrimaAditivosScreen extends StatelessWidget {
  const MateriaPrimaAditivosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Materia Prima y Aditivos Screen'),
        ElevatedButton(
          onPressed: () {
            // Aquí puedes agregar la funcionalidad del botón
          },
          child: const Text('Botón en MP y Aditivos'),
        ),
      ],
    );
  }
}

// Pantalla de "Defectos"
class DefectosScreen extends StatelessWidget {
  const DefectosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Defectos Screen'),
        ElevatedButton(
          onPressed: () {
            // Aquí puedes agregar la funcionalidad del botón
          },
          child: const Text('Botón en Defectos'),
        ),
      ],
    );
  }
}

// Pantalla de "Pesos"
class PesosScreen extends StatelessWidget {
  const PesosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Pesos Screen'),
        ElevatedButton(
          onPressed: () {
            // Aquí puedes agregar la funcionalidad del botón
          },
          child: const Text('Botón en Pesos'),
        ),
      ],
    );
  }
}

// Pantalla de "Monitoreo"
class MonitoreoScreen extends StatelessWidget {
  const MonitoreoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Monitoreo Screen'),
        ElevatedButton(
          onPressed: () {
            // Aquí puedes agregar la funcionalidad del botón
          },
          child: const Text('Botón en Monitoreo'),
        ),
      ],
    );
  }
}

// Pantalla de "Temperatura"
class TemperaturaScreen extends StatelessWidget {
  const TemperaturaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Temperatura Screen'),
        ElevatedButton(
          onPressed: () {
            // Aquí puedes agregar la funcionalidad del botón
          },
          child: const Text('Botón en Temperatura'),
        ),
      ],
    );
  }
}
