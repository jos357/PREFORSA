// lib/widgets/auxiliary_list.dart
import 'package:flutter/material.dart';

class AuxiliaryList extends StatelessWidget {
  const AuxiliaryList({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de nombres aleatorios
    final List<String> auxiliares = [
      'Juan Pérez',
      'María García',
      'Carlos Sánchez',
      'Lucía Fernández'
    ];

    return AlertDialog(
      title: const Text('Lista de Auxiliares'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: auxiliares.map((auxiliar) {
          return ListTile(
            title: Text(auxiliar),
          );
        }).toList(),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cerrar'),
          onPressed: () {
            Navigator.of(context).pop(); // Cerrar el popup
          },
        ),
      ],
    );
  }
}
