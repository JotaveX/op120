import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class UsuarioAtividadeCreateForm extends StatefulWidget {
  @override
  _UsuarioAtividadeCreateFormState createState() =>
      _UsuarioAtividadeCreateFormState();
}

class _UsuarioAtividadeCreateFormState
    extends State<UsuarioAtividadeCreateForm> {
  final TextEditingController _UsuarioIdController = TextEditingController();
  final TextEditingController _AtividadeIdController = TextEditingController();
  final TextEditingController _EntregaController = TextEditingController();
  final TextEditingController _NotaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        backgroundColor: Colors.pink,
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _UsuarioIdController,
                decoration: const InputDecoration(
                  labelText: 'Usuario Id',
                ),
              ),
              TextFormField(
                controller: _AtividadeIdController,
                decoration: const InputDecoration(
                  labelText: 'Ativiade Id',
                ),
              ),
              TextFormField(
                controller: _EntregaController,
                decoration: InputDecoration(
                  labelText: 'Data de Entrega',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        _EntregaController.text =
                            DateFormat('yyyy-MM-dd').format(date);
                      }
                    },
                  ),
                ),
              ),
              TextFormField(
                controller: _NotaController,
                decoration: const InputDecoration(
                  labelText: 'Nota',
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final response = await http.post(
                    Uri.parse('http://localhost:4000/usuario-atividade'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, String>{
                      'usuario_id': _UsuarioIdController.text,
                      'atividade_id': _AtividadeIdController.text,
                      'entrega': _EntregaController.text,
                      'nota': _NotaController.text,
                    }),
                  );
                  if (response.statusCode == 200) {
                    Navigator.pop(context);
                  } else {
                    throw Exception('Failed to edit task');
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Create Usuario Atividade'),
  //     ),
  //     body: Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Column(
  //         children: [
  //           TextField(
  //             controller: _UsuarioIdController,
  //             decoration: InputDecoration(
  //               labelText: 'Usuario Id',
  //             ),
  //           ),
  //           TextField(
  //             controller: _AtividadeIdController,
  //             decoration: InputDecoration(
  //               labelText: 'Atividade',
  //             ),
  //           ),
  //           TextField(
  //             controller: _EntregaController,
  //             decoration: InputDecoration(
  //               labelText: 'Entrega',
  //             ),
  //             obscureText: true,
  //           ),
  //           TextField(
  //             controller: _NotaController,
  //             decoration: InputDecoration(
  //               labelText: 'Nota',
  //             ),
  //           ),
  //           SizedBox(height: 16.0),
  //           ElevatedButton(
  //             onPressed: () async {
  //               // Handle form submission
  //               final int usuarioId = int.parse(_UsuarioIdController.text);
  //               final int atividadeId = int.parse(_AtividadeIdController.text);
  //               final String entrega = _EntregaController.text;
  //               final double nota = double.parse(_NotaController.text);

  //               // TODO: Perform create operation with the form data
  //               final response = await http
  //                   .post(
  //                     Uri.parse('http://localhost:4000/usuario-atividade'),
  //                     headers: <String, String>{
  //                       'Content-Type': 'application/json; charset=UTF-8',
  //                     },
  //                     body: jsonEncode(<String, String>{
  //                       'usuario_id': usuarioId.toString(),
  //                       'atividade_id': atividadeId.toString(),
  //                       'entrega': entrega,
  //                       'nota': nota.toString(),
  //                     }),
  //                   )
  //                   .then((value) => Navigator.pop(context));
  //               // Clear form fields
  //               _UsuarioIdController.clear();
  //               _AtividadeIdController.clear();
  //               _EntregaController.clear();
  //               _NotaController.clear();
  //             },
  //             child: Text('Create'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
