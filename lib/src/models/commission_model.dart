class ComissionModel {
  int id;
  int idLegislatura;
  String titulo;
  String uri;

  ComissionModel({
    required this.id,
    required this.idLegislatura,
    required this.titulo,
    required this.uri,
  });

  factory ComissionModel.fromJson(Map<String, dynamic> json) {
    return ComissionModel(
      id: json['id'],
      idLegislatura: json['idLegislatura'],
      titulo: json['titulo'],
      uri: json['uri'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idLegislatura'] = idLegislatura;
    data['titulo'] = titulo;
    data['uri'] = uri;
    return data;
  }
}
