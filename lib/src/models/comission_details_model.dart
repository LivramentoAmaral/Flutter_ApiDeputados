class ComissionDetailsModel {
  int id;
  int idLegislatura;
  String titulo;
  String uri;
  Coordinator coordinator;
  String email;
  int idSituacao;
  String keywords;
  String situacao;
  String telefone;
  String urlDocumento;
  String urlWebsite;

  ComissionDetailsModel({
    required this.id,
    required this.idLegislatura,
    required this.titulo,
    required this.uri,
    required this.coordinator,
    required this.email,
    required this.idSituacao,
    required this.keywords,
    required this.situacao,
    required this.telefone,
    required this.urlDocumento,
    required this.urlWebsite,
  });

  factory ComissionDetailsModel.fromMap(Map<String, dynamic> map) {
    return ComissionDetailsModel(
      id: map['id'] ?? 0, // Adicione verificação de nulidade e valor padrão
      idLegislatura: map['idLegislatura'] ??
          0, // Adicione verificação de nulidade e valor padrão
      titulo: map['titulo'] ?? '',
      uri: map['uri'] ?? '',
      coordinator: Coordinator.fromMap(map['coordenador'] ?? {}),
      email: map['email'] ?? '',
      idSituacao: map['idSituacao'] ??
          0, // Adicione verificação de nulidade e valor padrão
      keywords: map['keywords'] ?? '',
      situacao: map['situacao'] ?? '',
      telefone: map['telefone'] ?? '',
      urlDocumento: map['urlDocumento'] ?? '',
      urlWebsite: map['urlWebsite'] ?? '',
    );
  }
}

class Coordinator {
  String email;
  int id;
  int idLegislatura;
  String nome;
  String siglaPartido;
  String siglaUf;
  String uri;
  String uriPartido;
  String urlFoto;

  Coordinator({
    required this.email,
    required this.id,
    required this.idLegislatura,
    required this.nome,
    required this.siglaPartido,
    required this.siglaUf,
    required this.uri,
    required this.uriPartido,
    required this.urlFoto,
  });

  factory Coordinator.fromMap(Map<String, dynamic> map) {
    return Coordinator(
      email: map['email'] ?? '',
      id: map['id'] ?? 0, // Adicione verificação de nulidade e valor padrão
      idLegislatura: map['idLegislatura'] ??
          0, // Adicione verificação de nulidade e valor padrão
      nome: map['nome'] ?? '',
      siglaPartido: map['siglaPartido'] ?? '',
      siglaUf: map['siglaUf'] ?? '',
      uri: map['uri'] ?? '',
      uriPartido: map['uriPartido'] ?? '',
      urlFoto: map['urlFoto'] ?? '',
    );
  }

  get photo => null;

  get party => null;
}
