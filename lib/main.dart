import 'package:flutter/material.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.blueAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TelaListaTarefas(),
    );
  }
}

class TelaListaTarefas extends StatefulWidget {
  @override
  _TelaListaTarefasState createState() => _TelaListaTarefasState();
}

class _TelaListaTarefasState extends State<TelaListaTarefas> {
  final TextEditingController _controladorTarefa = TextEditingController();
  List<String> _tarefas = [];



  @override
  void initState() {
    super.initState();
  }

  void _adicionarTarefa(String titulo) {
    if (titulo.isNotEmpty) {
      setState(() {
        _tarefas.add(titulo);
      });
      _controladorTarefa.clear(); 
    }
  }

  void _removerTarefa(int indice) {
    setState(() {
      _tarefas.removeAt(indice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _tarefas.isEmpty
                ? Center(
                    child: Text(
                      'Nenhuma tarefa adicionada ainda.',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: _tarefas.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(_tarefas[index]),
                        onDismissed: (direcao) {
                          _removerTarefa(index);
                        },
                        background: Container(
                          color: Colors.red,
                          child: Icon(Icons.delete, color: Colors.white),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20.0),
                        ),
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: ListTile(
                            title: Text(
                              _tarefas[index],
                              style: TextStyle(fontSize: 20),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _removerTarefa(index),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controladorTarefa,
                    decoration: InputDecoration(
                      hintText: 'Adicionar nova tarefa',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _adicionarTarefa(_controladorTarefa.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
