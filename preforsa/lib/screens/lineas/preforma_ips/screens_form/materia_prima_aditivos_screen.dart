import 'package:flutter/material.dart';

class MateriaPrimaAditivosScreen extends StatelessWidget {
  const MateriaPrimaAditivosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Hola'),
        Wrap(
          children: [Text('Hola'), Text('Hola')],
        ),
      ],
    );
  }
}
