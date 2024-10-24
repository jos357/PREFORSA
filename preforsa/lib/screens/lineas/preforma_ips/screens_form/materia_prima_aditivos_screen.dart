import 'package:flutter/material.dart';

class MateriaPrimaAditivosScreen extends StatefulWidget {
  const MateriaPrimaAditivosScreen({super.key});

  @override
  State<MateriaPrimaAditivosScreen> createState() => _MateriaPrimaAditivosScreenState();
}

class _MateriaPrimaAditivosScreenState extends State<MateriaPrimaAditivosScreen> {
  List<Registro> registros = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Galería de Registros")),
        body: ListView.builder(
          itemCount: registros.length,
          itemBuilder: (context, index) {
            return RegistroWidget(
              registro: registros[index],
              onRemove: () {
                setState(() {
                  registros.removeAt(index);
                });
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              registros.add(Registro(
                materiaPrima: 'JADE CZ 328A',
                intFile: '',
                cantidadEmpaque: '1100 kg',
              ));
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

// Modelo para un registro
class Registro {
  String materiaPrima;
  String intFile;
  String cantidadEmpaque;
  int cantidadBolsones;
  double dosificacion;
  double humedad;
  bool conformidad;

  Registro({
    required this.materiaPrima,
    required this.intFile,
    required this.cantidadEmpaque,
    this.cantidadBolsones = 1,
    this.dosificacion = 0.0,
    this.humedad = 0.0,
    this.conformidad = false,
  });
}

// Widget para mostrar cada registro
class RegistroWidget extends StatelessWidget {
  final Registro registro;
  final VoidCallback onRemove;

  RegistroWidget({required this.registro, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: registro.materiaPrima,
              items: ['JADE CZ 328A', 'Otra opción']
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                // Aquí puedes actualizar el valor de materia prima
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'INT. FILE'),
              onChanged: (value) {
                // Aquí puedes actualizar intFile
              },
            ),
            DropdownButton<String>(
              value: registro.cantidadEmpaque,
              items: ['1100 kg', 'Otra opción']
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                // Aquí puedes actualizar cantidadEmpaque
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: '%DOSIF.'),
                    onChanged: (value) {
                      // Aquí puedes actualizar la dosificación
                    },
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: '%HUM.'),
                    onChanged: (value) {
                      // Aquí puedes actualizar la humedad
                    },
                  ),
                ),
              ],
            ),
            CheckboxListTile(
              title: Text('Conformidad'),
              value: registro.conformidad,
              onChanged: (value) {
                // Aquí puedes actualizar la conformidad
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
  }