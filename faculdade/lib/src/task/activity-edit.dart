import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:faculdade/src/models/atividade.model.dart';
import 'package:intl/intl.dart';
// Remove the unused import directive
import 'package:http/http.dart' as http;

class EditTaskWidget extends StatefulWidget {
  final int atvId;

  EditTaskWidget({required this.atvId});

  @override
  _EditTaskWidgetState createState() => _EditTaskWidgetState();
}

class _EditTaskWidgetState extends State<EditTaskWidget> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController dataEntregaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAtividade();
  }

  Future<void> fetchAtividade() async {
    final response = await http
        .get(Uri.parse('http://localhost:4000/atividade/${widget.atvId}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)[0];
      print(data);
      setState(() {
        tituloController.text = data['titulo'].toString();
        descricaoController.text = data['descricao'].toString();
        dataEntregaController.text = DateFormat('yyyy-MM-dd').format(
          DateTime.parse(data['dataEntrega']),
        );
      });
    } else {
      throw Exception('Failed to fetch atividade');
    }
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
                  final response = await http.put(
                    Uri.parse(
                        'http://localhost:4000/atividade/${widget.atvId}'),
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
                child: const Text('Edit'),
              ),
              const SizedBox(height: 10),
              // ElevatedButton(
              //   onPressed: () {
              //     showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         return AlertDialog(
              //           title: const Text('Delete Task'),
              //           content: const Text('Are you sure you want to delete?'),
              //           actions: [
              //             TextButton(
              //               onPressed: () async {
              //                 final response = await http.delete(
              //                   Uri.parse(
              //                       'http://localhost:4000/atividade/${widget.atvId}'),
              //                 );
              //                 if (response.statusCode == 200) {
              //                   Navigator.pop(context);
              //                   Navigator.pop(context);
              //                 } else {
              //                   throw Exception('Failed to delete task');
              //                 }
              //               },
              //               child: const Text('Yes'),
              //             ),
              //             TextButton(
              //               onPressed: () {
              //                 Navigator.pop(context);
              //               },
              //               child: const Text('No'),
              //             ),
              //           ],
              //         );
              //       },
              //     );
              //   },
              //   child: const Text('Delete'),
              // ),
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
  //       title: const Text('Edit Task'),
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
  //                 tituloController = value;
  //               });
  //             },
  //           ),
  //           SizedBox(height: 10), // Add some spacing
  //           TextField(
  //             decoration: const InputDecoration(
  //               labelText: 'Descricao',
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
  //               labelText: 'DataAtv',
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
  //             onPressed: () async {
  //               final response = await http
  //                   .put(
  //                     Uri.parse(
  //                         'http://localhost:4000/atividade/${widget.atvId}'),
  //                     headers: <String, String>{
  //                       'Content-Type': 'application/json; charset=UTF-8',
  //                     },
  //                     body: jsonEncode(<String, String>{
  //                       'titulo': titulo,
  //                       'descricao': descricao,
  //                       'dataEntrega': dataEntrega
  //                     }),
  //                   )
  //                   .then((value) => Navigator.pop(context));

  //               // if (response.statusCode == 200) {
  //               //   // If the server returns a 200 OK response,
  //               //   // then parse the JSON.
  //               //   print('Task edited successfully');
  //               // } else {
  //               //   // If the server did not return a 200 OK response,
  //               //   // then throw an exception.
  //               //   throw Exception('Failed to edit task');
  //               // }
  //             },
  //             child: const Text('Edit'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
