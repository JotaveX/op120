import 'dart:convert';

import 'package:faculdade/src/usuario-atividade/usuarioAtividade-edit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'usuarioAtividade-create.dart';

class UsuarioAtividadeList extends StatefulWidget {
  @override
  _UsuarioAtividadeListState createState() => _UsuarioAtividadeListState();
}

class _UsuarioAtividadeListState extends State<UsuarioAtividadeList> {
  List<dynamic> atividades = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://localhost:4000/usuario-atividade'));
    if (response.statusCode == 200) {
      setState(() {
        atividades = jsonDecode(response.body);
        print(atividades);
      });
    } else {
      print('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuario Atividade List'),
      ),
      body: ListView.builder(
        itemCount: atividades.length,
        itemBuilder: (context, index) {
          final atividade = atividades[index];
          final userId = atividade['usuario_id'].toString();
          final entrega = DateFormat('yyyy-MM-dd').format(
            DateTime.parse(atividade['entrega']),
          );
          return ListTile(
            title: Text('Usuario: $userId'),
            subtitle: Text('Entrega: $entrega'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UsuarioAtividadeEditForm(
                          id: atividade['id'].toString(),
                        ),
                      ),
                    ).then((value) => fetchData());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    final delete = await http.delete(
                      Uri.parse(
                          'http://localhost:4000/usuario-atividade/${atividade['id']}'),
                    );
                    if (delete.statusCode == 200) {
                      fetchData();
                      print('Deleted');
                    } else {
                      print('Failed to delete');
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UsuarioAtividadeCreateForm()),
          ).then((value) => fetchData());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
