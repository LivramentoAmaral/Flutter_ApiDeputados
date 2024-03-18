import 'dart:convert';
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

  Future<DeputyModel> getDeputyById(int id) async {
    final String requestUrl = '$baseUrl/$id';

    try {
      final response = await http.get(
        Uri.parse(requestUrl),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = json.decode(response.body);

        if (responseData != null && responseData.containsKey('dados')) {
          final Map<String, dynamic> data = responseData['dados'];
          final deputy = DeputyModel(
            name: data['nome'] ?? '',
            party: data['siglaPartido'] ?? '',
            state: data['siglaUf'] ?? '',
            email: data['email'] ?? '',
            photo: data['urlFoto'] ?? '',
            phone: data['telefone'] ?? '',
            address: data['endereco'] ?? '',
            social: data['redeSocial'] ?? '',
            site: data['uri'] ?? '',
            biography: data['biografia'] ?? '',
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

  Future<List<DeputyModel>> getDeputiesByParty(String party) async {
    final String requestUrl = '$baseUrl?siglaPartido=$party';

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

  Future<List<DeputyModel>> getDeputiesByState(String state) async {
    final String requestUrl = '$baseUrl?siglaUf=$state';

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


  
}
