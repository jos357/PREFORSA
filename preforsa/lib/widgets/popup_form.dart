// lib/widgets/popup_form.dart
import 'package:flutter/material.dart';

class PopupForm extends StatelessWidget {
  const PopupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _passwordController = TextEditingController();

    return AlertDialog(
      title: const Text('Verificar Supervisor'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Por favor ingrese la contraseña de supervisor'),
          TextField(
            controller: _passwordController,
            obscureText: true, // Campo de contraseña
            decoration: const InputDecoration(labelText: 'Contraseña'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop(); // Cerrar el popup
          },
        ),
        TextButton(
          child: const Text('Verificar'),
          onPressed: () {
            String password = _passwordController.text;
            if (password == '12345') {
              Navigator.of(context)
                  .pop(); // Cerrar si la verificación es correcta
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contraseña incorrecta')),
              );
            }
          },
        ),
      ],
    );
  }
}
