// lib/widgets/popup_form.dart
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PopupForm extends StatelessWidget {
  const PopupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();

    Future<void> verifyPassword(
        BuildContext context, String inputPassword) async {
      try {
        // Obtener todos los usuarios con el rol de Supervisor
        QuerySnapshot<Map<String, dynamic>> supervisorSnapshot =
            await FirebaseFirestore.instance
                .collection('usuarios')
                .where('rol', isEqualTo: 'supervisor')
                .get();

        bool isPasswordCorrect = false;
        String supervisorName = '';

        // Iterar sobre los supervisores para verificar la contraseña
        for (var doc in supervisorSnapshot.docs) {
          String firestorePassword = doc.data()['password'];
          String userName = doc.data()['nombre'];

          if (inputPassword == firestorePassword) {
            // Si la contraseña coincide, guardar el nombre y marcar la verificación como correcta
            isPasswordCorrect = true;
            supervisorName = userName;
            break; // Salir del loop si encontramos una coincidencia
          }
        }

        if (isPasswordCorrect) {
          // Si la verificación fue correcta, mostrar el mensaje de bienvenida
          Navigator.of(context).pop(); // Cerrar el formulario
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Bienvenido'),
                content: Text('Bienvenido Ingeniero $supervisorName'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Aceptar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          // Mostrar mensaje de error si la contraseña es incorrecta
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contraseña incorrecta')),
          );
        }
      } catch (e) {
        // Manejar errores de Firestore
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al verificar: $e')),
        );
      }
    }

    return AlertDialog(
      title: const Text('Verificar Supervisor'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Por favor ingrese la contraseña de supervisor'),
          TextField(
            controller: passwordController,
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
            // Llamar a la función que verifica la contraseña en Firestore
            verifyPassword(context, passwordController.text);
          },
        ),
      ],
    );
  }
}
