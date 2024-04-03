import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class UsuarioAtividadeEditForm extends StatefulWidget {
  final String id;

  const UsuarioAtividadeEditForm({Key? key, required this.id})
      : super(key: key);

  @override
  _UsuarioAtividadeEditFormState createState() =>
      _UsuarioAtividadeEditFormState();
}

class _UsuarioAtividadeEditFormState extends State<UsuarioAtividadeEditForm> {
  final TextEditingController _UsuarioIdController = TextEditingController();
  final TextEditingController _AtividadeIdController = TextEditingController();
  final TextEditingController _EntregaController = TextEditingController();
  final TextEditingController _NotaController = TextEditingController();

  Future<void> fetchUsuarioAtividade() async {
    final response = await http.get(
      Uri.parse('http://localhost:4000/usuario-atividade/${widget.id}'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)[0];
      _UsuarioIdController.text = data['usuario_id'].toString();
      _AtividadeIdController.text = data['atividade_id'].toString();
      _EntregaController.text = DateFormat('yyyy-MM-dd').format(
        DateTime.parse(data['entrega']),
      );
      _NotaController.text = data['nota'].toString();
    } else {
      throw Exception('Failed to fetch usuario atividade');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsuarioAtividade();
  }

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
                  final response = await http.put(
                    Uri.parse(
                        'http://localhost:4000/usuario-atividade/${widget.id}'),
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
                child: const Text('Edit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Add your necessary variables and controllers here
}
