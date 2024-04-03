import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// Remove the unused import directive
import 'package:http/http.dart' as http;

class CreateTaskWidget extends StatefulWidget {
  @override
  _CreateTaskWidgetState createState() => _CreateTaskWidgetState();
}

class _CreateTaskWidgetState extends State<CreateTaskWidget> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController dataEntregaController = TextEditingController();

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
                controller: tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
              ),
              TextFormField(
                controller: descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
              ),
              TextFormField(
                controller: dataEntregaController,
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
                        dataEntregaController.text =
                            DateFormat('yyyy-MM-dd').format(date);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  print('titulo: ${tituloController.text}');
                  print('descricao: ${descricaoController.text}');
                  print('dataEntrega: ${dataEntregaController.text}');
                  final response = await http.post(
                    Uri.parse('http://localhost:4000/atividade'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, String>{
                      'titulo': tituloController.text,
                      'descricao': descricaoController.text,
                      'dataEntrega': dataEntregaController.text,
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
  //       title: const Text('Create Task'),
  //       backgroundColor: Colors.pink,
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           TextField(
  //             decoration: const InputDecoration(
  //               labelText: 'Titulo',
  //               border: OutlineInputBorder(),
  //               contentPadding: EdgeInsets.all(10),
  //             ),
  //             onChanged: (value) {
  //               setState(() {
  //                 titulo = value;
  //               });
  //             },
  //           ),
  //           SizedBox(height: 10), // Add some spacing
  //           TextField(
  //             decoration: const InputDecoration(
  //               labelText: 'Descrição',
  //               border: OutlineInputBorder(),
  //               contentPadding: EdgeInsets.all(10),
  //             ),
  //             onChanged: (value) {
  //               setState(() {
  //                 descricao = value;
  //               });
  //             },
  //           ),
  //           SizedBox(height: 10), // Add some spacing
  //           SizedBox(height: 10), // Add some spacing
  //           TextField(
  //             decoration: const InputDecoration(
  //               labelText: 'Data',
  //               border: OutlineInputBorder(),
  //               contentPadding: EdgeInsets.all(10),
  //             ),
  //             onChanged: (value) {
  //               setState(() {
  //                 dataEntrega = value;
  //               });
  //             },
  //           ),
  //           const SizedBox(height: 10), // Add some spacing
  //           ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //               foregroundColor: Colors.white,
  //               backgroundColor: Colors.pink, // Set the text color
  //             ),
  //             onPressed: () async {
  //               // TODO: Implement logic to create user

  //               final response = await http
  //                   .post(
  //                     Uri.parse('http://localhost:4000/atividade'),
  //                     headers: <String, String>{
  //                       'Content-Type': 'application/json; charset=UTF-8',
  //                     },
  //                     body: jsonEncode(<String, String>{
  //                       'titulo': titulo,
  //                       'descricao': descricao,
  //                       'dataEntrega': dataEntrega,
  //                     }),
  //                   )
  //                   .then((value) => Navigator.pushNamed(context, '/task'));

  //               // if (response.statusCode == 200) {
  //               //   // If the server returns a 200 OK response,
  //               //   // then parse the JSON.
  //               //   print('User created successfully');
  //               // } else {
  //               //   // If the server did not return a 200 OK response,
  //               //   // then throw an exception.
  //               //   throw Exception('Failed to create user');
  //               // }
  //             },
  //             child: const Text('Create'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
