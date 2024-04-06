class MembersComissionModel {
  final int codTitulo;
  final String dataFim;
  final String dataInicio;
  final String email;
  final int id;
  final int idLegislatura;
  final String nome;
  final String siglaPartido;
  final String siglaUf;
  final String titulo;
  final String uri;
  final String uriPartido;
  final String urlFoto;

  MembersComissionModel({
    required this.codTitulo,
    required this.dataFim,
    required this.dataInicio,
    required this.email,
    required this.id,
    required this.idLegislatura,
    required this.nome,
    required this.siglaPartido,
    required this.siglaUf,
    required this.titulo,
    required this.uri,
    required this.uriPartido,
    required this.urlFoto,
  });

  factory MembersComissionModel.fromMap(Map<String, dynamic> map) {
    return MembersComissionModel(
      codTitulo: map['codTitulo'] ?? 0,
      dataFim: map['dataFim'] ?? '',
      dataInicio: map['dataInicio'] ?? '',
      email: map['email'] ?? '',
      id: map['id'] ?? 0,
      idLegislatura: map['idLegislatura'] ?? 0,
      nome: map['nome'] ?? '',
      siglaPartido: map['siglaPartido'] ?? '',
      siglaUf: map['siglaUf'] ?? '',
      titulo: map['titulo'] ?? '',
      uri: map['uri'] ?? '',
      uriPartido: map['uriPartido'] ?? '',
      urlFoto: map['urlFoto'] ?? 'https://example.com/default-image.jpg',
    );
  }
}
