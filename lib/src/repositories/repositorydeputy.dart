import 'dart:convert';
import 'package:flutter_deputyapp/src/models/deputyid_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_deputyapp/src/models/deputy_model.dart';

class DeputyRepository {
  final String baseUrl = 'https://dadosabertos.camara.leg.br/api/v2/deputados';

  Future<List<DeputyModel>> getDeputies(
      {String? name, String? party, String? state, int? id}) async {
    final Map<String, String> queryParams = {};

    if (name != null) queryParams['nome'] = name;
    if (party != null) queryParams['siglaPartido'] = party;
    if (state != null) queryParams['siglaUf'] = state;
    if (id != null) queryParams['id'] = id.toString();

    String queryString = Uri(queryParameters: queryParams).query;
    String requestUrl = '$baseUrl?$queryString';

    try {
      final response = await http.get(
        Uri.parse(requestUrl),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = json.decode(response.body);

        if (responseData != null && responseData.containsKey('dados')) {
          final List<dynamic> data = responseData['dados'];
          final List<DeputyModel> deputies = [];

          for (final item in data) {
            final deputy = DeputyModel(
              id: item['id'],
              name: item['nome'] ?? '',
              party: item['siglaPartido'] ?? '',
              state: item['siglaUf'] ?? '',
              email: item['email'] ?? '',
              photo: item['urlFoto'] ?? '',
              phone: item['telefone'] ?? '',
              address: item['endereco'] ?? '',
              social: item['redeSocial'] ?? '',
              site: item['uri'] ?? '',
              biography: item['biografia'] ?? '',
            );
            deputies.add(deputy);
          }
          return deputies;
        } else {
          throw Exception(
              'Erro ao carregar deputados: dados não encontrados na resposta');
        }
      } else {
        throw Exception('Erro ao carregar deputados: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar deputados: $e');
      throw Exception('Erro ao carregar deputados: $e');
    }
  }

  Future<DeputyModelId> getDeputyById(int id) async {
    final String requestUrl = '$baseUrl/$id';

    try {
      final response = await http.get(
        Uri.parse(requestUrl),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = json.decode(response.body);

        if (responseData != null && responseData.containsKey('dados')) {
          final Map<String, dynamic> data = responseData['dados'];
          final deputy = DeputyModelId(
            nome: data['nome'] ?? '',
            cpf: data['cpf'] ?? '',
            dataFalecimento: data['dataFalecimento'] ?? '',
            dataNascimento: data['dataNascimento'] ?? '',
            escolaridade: data['escolaridade'] ?? '',
            id: data['id'] ?? 0,
            municipioNascimento: data['municipioNascimento'] ?? '',
            nomeCivil: data['nomeCivil'] ?? '',
            redeSocial: List<String>.from(data['redeSocial'] ?? []),
            sexo: data['sexo'] ?? '',
            ufNascimento: data['ufNascimento'] ?? '',
            ultimoStatus: Status.fromJson(data['ultimoStatus']),
            uri: data['uri'] ?? '',
            urlWebsite: data['urlWebsite'] ?? '',
            links: (responseData['links'] as List<dynamic>)
                .map((link) => Link.fromJson(link))
                .toList(),
          );
          return deputy;
        } else {
          throw Exception(
              'Erro ao carregar deputado: dados não encontrados na resposta');
        }
      } else {
        throw Exception('Erro ao carregar deputado: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar deputado: $e');
      throw Exception('Erro ao carregar deputado: $e');
    }
  }
}
