class Tarefa {
  int? id;
  String titulo;
  int concluida;

  Tarefa({this.id, required this.titulo, this.concluida = 0});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'concluida': concluida,
    };
  }

  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'],
      titulo: map['titulo'],
      concluida: map['concluida'],
    );
  }
}
