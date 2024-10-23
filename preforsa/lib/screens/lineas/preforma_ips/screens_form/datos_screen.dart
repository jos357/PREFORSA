import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatosScreen extends StatefulWidget {
  const DatosScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DatosScreenState createState() => _DatosScreenState();
}

class _DatosScreenState extends State<DatosScreen> {
  // Variables para almacenar los valores seleccionados
  String _selectedEmpaque = ''; // Para el dropdown de EMPAQUE
  String _selectedGramaje = ''; // Para el dropdown de GRAMAJE
  String _selectedValue = ''; // Para mostrar el valor del campo seleccionado
  String _selectedModalidad = 'Normal';
  String _selectedMaquinista = '';
  String _selectedProducto = 'CRISTAL EC30';
  String _selectedCavidades = '96';

  List<String> maquinistas = []; // Lista de maquinistas
  List<String> empaques = []; // Lista de documentos para EMPAQUE
  List<String> gramajes = []; // Lista de gramajes (nombres de los campos)

  // Para almacenar los datos del documento seleccionado
  Map<String, dynamic> selectedDocumentData = {};

  @override
  void initState() {
    super.initState();
    fetchEmpaques(); // Llamamos a la función para obtener los documentos de empaques
    fetchMaquinistas(); // Llamamos a la función para obtener los datos
  }

  // Función para obtener datos de Firestore
  Future<void> fetchMaquinistas() async {
    try {
      // Accede a la colección 'personal ajeno' en Firestore
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('personal ajeno').get();

      // Extraemos los nombres de los documentos y los almacenamos en la lista de maquinistas
      List<String> fetchedMaquinistas = snapshot.docs
          .map((doc) => doc['nombre']
              .toString()) // Asegúrate de que 'nombre' es el campo en los documentos
          .toList();

      // Actualizamos el estado para poblar el dropdown
      setState(() {
        maquinistas = fetchedMaquinistas;
        _selectedMaquinista = maquinistas.isNotEmpty ? maquinistas[0] : '';
      });
    } catch (e) {
      print('Error al obtener los datos de Firestore: $e');
    }
  }

  // Función para obtener los documentos de 'empaque gramaje'
  Future<void> fetchEmpaques() async {
    try {
      // Accedemos a la colección 'empaque gramaje'
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('empaque gramaje').get();

      // Extraemos los nombres de los documentos (empaques)
      List<String> fetchedEmpaques =
          snapshot.docs.map((doc) => doc.id).toList();

      // Actualizamos el estado para poblar el dropdown de empaques
      setState(() {
        empaques = fetchedEmpaques;
        _selectedEmpaque = empaques.isNotEmpty ? empaques[0] : '';
        if (_selectedEmpaque.isNotEmpty) {
          fetchGramajes(
              _selectedEmpaque); // Cargar los gramajes del primer empaque
        }
      });
    } catch (e) {
      print('Error al obtener los empaques de Firestore: $e');
    }
  }

  // Función para obtener los gramajes de un documento seleccionado (empaque)
  Future<void> fetchGramajes(String empaque) async {
    try {
      // Accedemos al documento seleccionado en la colección 'empaque gramaje'
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('empaque gramaje')
          .doc(empaque)
          .get();

      // Obtenemos los datos del documento seleccionado
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        setState(() {
          selectedDocumentData = data;
          gramajes = data.keys.toList(); // Nombres de los campos (gramajes)
          _selectedGramaje = gramajes.isNotEmpty ? gramajes[0] : '';
          _selectedValue =
              data[_selectedGramaje].toString(); // Valor del primer gramaje
        });
      }
    } catch (e) {
      print('Error al obtener los gramajes de Firestore: $e');
    }
  }

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
                _buildDropdownField('MODALIDAD DE PRODUCCIÓN',
                    ['Normal', 'Prueba'], _selectedModalidad, (newValue) {
                  setState(() {
                    _selectedModalidad = newValue!;
                  });
                }),
                _buildTextFieldEdit('LOTE'),
                // Maquinistas dropdown
                _buildDropdownField(
                    'MAQUINISTA', maquinistas, _selectedMaquinista, (newValue) {
                  setState(() {
                    _selectedMaquinista = newValue!;
                  });
                }),
                // Dropdown de EMPAQUE
                _buildTextFieldEdit('PARTE'),
                _buildDropdownField(
                    'PRODUCTO',
                    ['CRISTAL EC30', 'Otro Producto'],
                    _selectedProducto, (newValue) {
                  setState(() {
                    _selectedProducto = newValue!;
                  });
                }),
                // Dropdown de GRAMAJE
                _buildDropdownField('GRAMAJE', gramajes, _selectedGramaje,
                    (newValue) {
                  setState(() {
                    _selectedGramaje = newValue!;
                    _selectedValue = selectedDocumentData[_selectedGramaje]
                        .toString(); // Mostrar valor
                  });
                }),
                _buildTextFieldEdit('CICLO PROM'),
                _buildDropdownField(
                    'CAVIDADES HABILITADAS',
                    ['96', '95', '94', '93', '92', '91', '90'],
                    _selectedCavidades, (newValue) {
                  setState(() {
                    _selectedCavidades = newValue!;
                  });
                }),
                _buildTextFieldEdit('PESO PROMEDIO'),
                _buildTextFieldEdit('PA INICIAL'),
                _buildTextFieldEdit('PA FINAL'),
                _buildDropdownField('EMPAQUE', empaques, _selectedEmpaque,
                    (newValue) {
                  setState(() {
                    _selectedEmpaque = newValue!;
                    fetchGramajes(
                        _selectedEmpaque); // Cargar gramajes para el empaque seleccionado
                  });
                }),

                // TextField para mostrar el valor del gramaje seleccionado
                _buildTextField('CANTIDAD', _selectedValue),
                _buildTextFieldEdit('PESO PROM. EN CONT. NETO'),
                _buildTextFieldEdit('TOTAL DE CAJAS CONTROLADAS'),
                _buildTextFieldEdit('SALDOS'),
                _buildTextFieldEdit('TOTAL DE CAJAS PRODUCIDAS'),
                _buildTextFieldEdit('CANTIDAD TOTAL PIEZAS'),
                _buildTextFieldEdit('CANTIDAD TOTAL KG'),
                _buildTextFieldEdit('CANTIDAD DE PROD. RETENIDO'),
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

  // Función para construir un TextField
  Widget _buildTextField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          readOnly: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: value, // Mostramos el valor seleccionado
          ),
        ),
      ],
    );
  }

  Widget _buildTextFieldEdit(String label) {
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

  // Función para construir un Dropdown
  Widget _buildDropdownField(String label, List<String> options,
      String selectedValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButton<String>(
          isExpanded: true,
          value: selectedValue.isNotEmpty ? selectedValue : null,
          items: options.isNotEmpty
              ? options.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()
              : [],
          onChanged: onChanged,
        ),
      ],
    );
  }
}
