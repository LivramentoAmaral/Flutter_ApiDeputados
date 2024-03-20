
class DeputyModel {
  final int id;
  final String name;
  final String party;
  final String state;
  final String email;
  final String photo;
  final String phone;
  final String address;
  final String social;
  final String site;
  final String biography;

  DeputyModel({
    required this.id,
    required this.name,
    required this.party,
    required this.state,
    required this.email,
    required this.photo,
    required this.phone,
    required this.address,
    required this.social,
    required this.site,
    required this.biography,
  });

  factory DeputyModel.fromJson(Map<String, dynamic> json) {
    return DeputyModel(
      id: json['id'],
      name: json['nome'],
      party: json['siglaPartido'],
      state: json['siglaUf'],
      email: json['email'],
      photo: json['urlFoto'],
      phone: json['telefone'],
      address: json['endereco'],
      social: json['redeSocial'],
      site: json['uri'],
      biography: json['biografia'],
    );
  }

  get dataNascimento => null;

  get dataFalecimento => null;

  get cpf => null;
}



