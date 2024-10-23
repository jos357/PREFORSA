import 'package:flutter/material.dart';
import 'package:preforsa/screens/lineas/preforma_ips/screen_preforma_ips.dart';


class Screen_principal extends StatefulWidget {

  const Screen_principal({super.key});

  @override
  State<Screen_principal> createState() => _nameState();
}

class _nameState extends State<Screen_principal> {
  bool _isObscured = true;
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Spacer para empujar el Container hacia abajo
          Spacer(),  
          
          // Container con el formulario de registro
          Center(
            child: Container(
              width: 322,
              height: 459,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xcc000000),  // Fondo semi-transparente
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Texto de título
                  Text(
                    "Bienvenido!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  
                  Text(
                    "Sistema de Control de Calidad",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),  // Espacio entre el título y los campos

                  // Campo de Username
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Usuario',
                      labelStyle: TextStyle(color: Colors.white,fontSize:16),
                      hintText: 'Usuario',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                   // Campo de Password
                  TextField(
      obscureText: _isObscured,  // Si es true, el texto está oculto; si es false, es visible
      decoration: InputDecoration(
        labelText: 'Contraseña',
        labelStyle: TextStyle(color: Colors.white,fontSize:16),
        hintText: 'xxxxxxxx',
        hintStyle: TextStyle(color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(
            // Muestra un ícono diferente según el estado de la contraseña
            _isObscured ? Icons.visibility_off : Icons.visibility,
            color: Colors.white,
          ),
          onPressed: () {
            // Cambia la visibilidad de la contraseña
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
    ),
                  SizedBox(height: 30),

                  // Botón de registro
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScreenPreformaIPS()),  // Nueva clase
                );// Acción al presionar el botón
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      backgroundColor: Colors.orange, // Color de fondo
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "INGRESAR",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Texto de inicio de sesión
                  RichText(
                    text: TextSpan(
                      text: "Desarrollado por ",
                      style: TextStyle(color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'DEV-SIGMA',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Espacio inferior para dejar margen al final de la pantalla
          SizedBox(height: 30),
        ],
      ),
    );
  }
}


