class DeputyModelId {
  final String cpf;
  final String dataFalecimento;
  final String dataNascimento;
  final String escolaridade;
  final int id;
  final String municipioNascimento;
  final String nomeCivil;
  final List<String> redeSocial;
  final String sexo;
  final String ufNascimento;
  final Status ultimoStatus;
  final String uri;
  final String urlWebsite;
  final List<Link> links;
  final String photo;
  final String nome;

  DeputyModelId({
    required this.nome,
    required this.cpf,
    required this.dataFalecimento,
    required this.dataNascimento,
    required this.escolaridade,
    required this.id,
    required this.municipioNascimento,
    required this.nomeCivil,
    required this.redeSocial,
    required this.sexo,
    required this.ufNascimento,
    required this.ultimoStatus,
    required this.uri,
    required this.urlWebsite,
    required this.links,
    this.photo = '',
  });

  factory DeputyModelId.fromJson(Map<String, dynamic> json) {
    return DeputyModelId(
          nome: json['dados']['nome'] ?? '',
          cpf: json['dados']['cpf'] ?? '',
          dataFalecimento: json['dados']['dataFalecimento'] ?? '',
          dataNascimento: json['dados']['dataNascimento'] ?? '',
          photo: json['dados']['urlFoto'] ?? '',
          escolaridade: json['dados']['escolaridade'] ?? '',
          id: json['dados']['id'] ?? 0,
          municipioNascimento: json['dados']['municipioNascimento'] ?? '',
          nomeCivil: json['dados']['nomeCivil'] ?? '',
          redeSocial: List<String>.from(json['dados']['redeSocial']) ?? [],
          sexo: json['dados']['sexo'] ?? '',
          ufNascimento: json['dados']['ufNascimento'],
          ultimoStatus: Status.fromJson(json['dados']['ultimoStatus']) ??
              Status(
                condicaoEleitoral: '',
                data: '',
                descricaoStatus: '',
                email: '',
                gabinete: Gabinete(
                  andar: '',
                  email: '',
                  nome: '',
                  predio: '',
                  sala: '',
                  telefone: '',
                ),
                id: 0,
                idLegislatura: 0,
                nome: '',
                nomeEleitoral: '',
                siglaPartido: '',
                siglaUf: '',
                situacao: '',
                uri: '',
                uriPartido: '',
                urlFoto: '',
              ),
          uri: json['dados']['uri'] ?? '',
          urlWebsite: json['dados']['urlWebsite'] ?? '',
          links: (json['links'] as List<dynamic>)
              .map((link) => Link.fromJson(link))
              .toList(),
        ) ??
        DeputyModelId(
          nome: '',
          cpf: '',
          dataFalecimento: '',
          dataNascimento: '',
          escolaridade: '',
          id: 0,
          municipioNascimento: '',
          nomeCivil: '',
          redeSocial: [],
          sexo: '',
          ufNascimento: '',
          ultimoStatus: Status(
            condicaoEleitoral: '',
            data: '',
            descricaoStatus: '',
            email: '',
            gabinete: Gabinete(
              andar: '',
              email: '',
              nome: '',
              predio: '',
              sala: '',
              telefone: '',
            ),
            id: 0,
            idLegislatura: 0,
            nome: '',
            nomeEleitoral: '',
            siglaPartido: '',
            siglaUf: '',
            situacao: '',
            uri: '',
            uriPartido: '',
            urlFoto: '',
          ),
          uri: '',
          urlWebsite: '',
          links: [],
        );
  }
}

class Status {
  final String condicaoEleitoral;
  final String data;
  final String descricaoStatus;
  final String email;
  final Gabinete gabinete;
  final int id;
  final int idLegislatura;
  final String nome;
  final String nomeEleitoral;
  final String siglaPartido;
  final String siglaUf;
  final String situacao;
  final String uri;
  final String uriPartido;
  final String urlFoto;

  Status({
    required this.condicaoEleitoral,
    required this.data,
    required this.descricaoStatus,
    required this.email,
    required this.gabinete,
    required this.id,
    required this.idLegislatura,
    required this.nome,
    required this.nomeEleitoral,
    required this.siglaPartido,
    required this.siglaUf,
    required this.situacao,
    required this.uri,
    required this.uriPartido,
    required this.urlFoto,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      condicaoEleitoral: json['condicaoEleitoral'],
      data: json['data'],
      descricaoStatus: json['descricaoStatus'],
      email: json['email'],
      gabinete: Gabinete.fromJson(json['gabinete']),
      id: json['id'],
      idLegislatura: json['idLegislatura'],
      nome: json['nome'],
      nomeEleitoral: json['nomeEleitoral'],
      siglaPartido: json['siglaPartido'],
      siglaUf: json['siglaUf'],
      situacao: json['situacao'],
      uri: json['uri'],
      uriPartido: json['uriPartido'],
      urlFoto: json['urlFoto'],
    );
  }
}

class Gabinete {
  final String andar;
  final String email;
  final String nome;
  final String predio;
  final String sala;
  final String telefone;

  Gabinete({
    required this.andar,
    required this.email,
    required this.nome,
    required this.predio,
    required this.sala,
    required this.telefone,
  });

  factory Gabinete.fromJson(Map<String, dynamic> json) {
    return Gabinete(
      andar: json['andar'],
      email: json['email'],
      nome: json['nome'],
      predio: json['predio'],
      sala: json['sala'],
      telefone: json['telefone'],
    );
  }
}

class Link {
  final String href;
  final String rel;
  final String type;

  Link({
    required this.href,
    required this.rel,
    required this.type,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      href: json['href'],
      rel: json['rel'],
      type: json['type'],
    );
  }
}
