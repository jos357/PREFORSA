import 'package:flutter/material.dart';

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
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.8,
              children: <Widget>[
                _buildDropdownField(
                    'MODALIDAD DE PRODUCCIÓN', ['Normal', 'Otra'], 'Normal'),
                _buildTextField('LOTE'),
                _buildDropdownField('MAQUINISTA', ['Agustin Fernandez', 'Otro'],
                    'Agustin Fernandez'),
                _buildTextField('PARTE'),
                _buildDropdownField('PRODUCTO',
                    ['CRISTAL EC30', 'Otro Producto'], 'CRISTAL EC30'),
                _buildDropdownField(
                    'GRAMAJE', ['20,1 M5 R', 'Otro Gramaje'], '20,1 M5 R'),
                _buildTextField('CICLO PROM'),
                _buildDropdownField(
                    'CAVIDADES HABILITADAS', ['96', 'Otra cantidad'], '96'),
                _buildTextField('PESO PROMEDIO'),
                _buildTextField('PA INICIAL'),
                _buildTextField('PA FINAL'),
                _buildDropdownField('EMPAQUE', ['JAULA GRANDE', 'Otro Empaque'],
                    'JAULA GRANDE'),
                _buildTextField('CANTIDAD'),
                _buildTextField('PESO PROM. EN CONT. NETO'),
                _buildTextField('TOTAL DE CAJAS CONTROLADAS'),
                _buildTextField('SALDOS'),
                _buildTextField('TOTAL DE CAJAS PRODUCIDAS'),
                _buildTextField('CANTIDAD TOTAL PIEZAS'),
                _buildTextField('CANTIDAD TOTAL KG'),
                _buildTextField('CANTIDAD DE PROD. RETENIDO'),
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
