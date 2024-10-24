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

  // Controladores para los campos editables
  TextEditingController pesoPromedioController = TextEditingController();
  TextEditingController pesoPromNetoController = TextEditingController();
  double cantidad = 0.0; // Se calculará a partir de gramaje y empaque

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

      List<String> fetchedMaquinistas =
          snapshot.docs.map((doc) => doc['nombre'].toString()).toList();

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
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('empaque gramaje').get();

      List<String> fetchedEmpaques =
          snapshot.docs.map((doc) => doc.id).toList();

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
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('empaque gramaje')
          .doc(empaque)
          .get();

      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        setState(() {
          selectedDocumentData = data;
          gramajes = data.keys.toList();
          _selectedGramaje = gramajes.isNotEmpty ? gramajes[0] : '';
          _selectedValue = data[_selectedGramaje].toString();
          calcularCantidad(); // Calcular la cantidad basada en gramaje y empaque
        });
      }
    } catch (e) {
      print('Error al obtener los gramajes de Firestore: $e');
    }
  }

  // Función para calcular la cantidad basada en el valor de gramaje
  void calcularCantidad() {
    if (_selectedValue.isNotEmpty) {
      setState(() {
        cantidad = double.tryParse(_selectedValue) ?? 0.0;
        calcularPesoPromNeto(); // Recalcular cuando se cambia la cantidad
      });
    }
  }

  // Función para calcular el PESO PROM. EN CONT. NETO
  void calcularPesoPromNeto() {
    double pesoPromedio = double.tryParse(pesoPromedioController.text) ?? 0.0;
    double resultado = (cantidad * pesoPromedio) / 1000;
    pesoPromNetoController.text =
        resultado.toStringAsFixed(1); // Redondeado a un decimal
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
                _buildDropdownField(
                    'MAQUINISTA', maquinistas, _selectedMaquinista, (newValue) {
                  setState(() {
                    _selectedMaquinista = newValue!;
                  });
                }),
                _buildTextFieldEdit('PARTE'),
                _buildDropdownField(
                    'PRODUCTO',
                    ['CRISTAL EC30', 'Otro Producto'],
                    _selectedProducto, (newValue) {
                  setState(() {
                    _selectedProducto = newValue!;
                  });
                }),
                _buildDropdownField('GRAMAJE', gramajes, _selectedGramaje,
                    (newValue) {
                  setState(() {
                    _selectedGramaje = newValue!;
                    _selectedValue =
                        selectedDocumentData[_selectedGramaje].toString();
                    calcularCantidad(); // Recalcular la cantidad al cambiar el gramaje
                  });
                }),
                _buildTextFieldEdit('CICLO PROM'),
                _buildDropdownField('CAVIDADES HABILITADAS',
                    ['96', '95', '94', '93'], _selectedCavidades, (newValue) {
                  setState(() {
                    _selectedCavidades = newValue!;
                  });
                }),
                _buildTextFieldEdit('PESO PROMEDIO', pesoPromedioController),
                _buildTextFieldEdit('PA INICIAL'),
                _buildTextFieldEdit('PA FINAL'),
                _buildDropdownField('EMPAQUE', empaques, _selectedEmpaque,
                    (newValue) {
                  setState(() {
                    _selectedEmpaque = newValue!;
                    fetchGramajes(_selectedEmpaque);
                  });
                }),
                _buildTextFieldView('CANTIDAD', cantidad.toString()),
                _buildTextFieldEdit(
                    'PESO PROM. EN CONT. NETO', pesoPromNetoController),
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

  // Función para construir un TextField con un controlador opcional
  Widget _buildTextFieldEdit(String label,
      [TextEditingController? controller]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          controller: controller,
          onChanged: (value) {
            if (controller == pesoPromedioController) {
              calcularPesoPromNeto(); // Recalcular cuando cambie el valor de peso promedio
            }
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  // Función para mostrar campos no editables
  Widget _buildTextFieldView(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          controller: TextEditingController(text: value),
          enabled: false,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  // Función para construir un Dropdown
  Widget _buildDropdownField(String label, List<String> items,
      String selectedValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButton<String>(
          value: selectedValue.isNotEmpty ? selectedValue : null,
          isExpanded: true,
          onChanged: onChanged,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
