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
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/FondoApp_1.jpg'), // Asegúrate de que la imagen esté en la carpeta correcta
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Contenido sobre la imagen
          Column(
            children: [
              Spacer(),
              
              // Container con el formulario
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
                      SizedBox(height: 20), // Espacio entre el título y los campos

                      // Campo de Usuario
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Usuario',
                          labelStyle: TextStyle(color: Colors.white, fontSize: 16),
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

                      // Campo de Contraseña
                      TextField(
                        obscureText: _isObscured, // Ocultar o mostrar texto
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                          hintText: 'xxxxxxxx',
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscured ? Icons.visibility_off : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
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
                            MaterialPageRoute(
                              builder: (context) => ScreenPreformaIPS(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          backgroundColor: Colors.orange, // Color del botón
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

                      // Texto inferior
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
              SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
