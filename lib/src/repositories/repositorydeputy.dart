// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter_deputyapp/src/models/comission_details_model.dart';
import 'package:flutter_deputyapp/src/models/commission_model.dart';
import 'package:flutter_deputyapp/src/models/deputyid_model.dart';
import 'package:flutter_deputyapp/src/models/expenses_model.dart';
import 'package:flutter_deputyapp/src/models/members_comission_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_deputyapp/src/models/deputy_model.dart';

class DeputyRepository {
  final String baseUrl = 'https://dadosabertos.camara.leg.br/api/v2/deputados';
  final String baseUrlComission =
      'https://dadosabertos.camara.leg.br/api/v2/frentes';

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

  Future<ParliamentarianDetails> getParliamentarianDetails(int id) async {
    final String requestUrl = '$baseUrl/$id';

    try {
      final response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('dados')) {
          final parliamentarianDetails =
              ParliamentarianDetails.fromMap(responseData['dados']);
          return parliamentarianDetails;
        } else {
          throw Exception(
              'Erro ao carregar detalhes do parlamentar: dados não encontrados na resposta');
        }
      } else {
        throw Exception(
            'Erro ao carregar detalhes do parlamentar: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar detalhes do parlamentar: $e');
      throw Exception('Erro ao carregar detalhes do parlamentar: $e');
    }
  }

  Future<List<ExpensesModel>> getAllExpenses(int id) async {
    final String requestUrl = '$baseUrl/$id/despesas?itens=1000';
    try {
      final response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData != null &&
            responseData is Map &&
            responseData.containsKey('dados')) {
          final List<dynamic>? data = responseData['dados'];
          final List<ExpensesModel> expenses = [];

          if (data != null) {
            for (final item in data) {
              if (item is Map<String, dynamic>) {
                final expense = ExpensesModel.fromMap(item);
                // ignore: unnecessary_null_comparison
                if (expense != null) {
                  // Certifica-se de que o modelo não é nulo
                  print(expense);
                  expenses.add(expense);
                }
              }
            }
          }
          return expenses;
        } else {
          return []; // Retorna uma lista vazia se não houver dados
        }
      } else {
        throw Exception('Erro ao carregar despesas: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar despesas: $e');
      throw Exception('Erro ao carregar despesas: $e');
    }
  }

  Future<List<ExpensesModel>> getExpensesByMonthAndYear(
      int id, int year, int month) async {
    print('month: $month');
    final String requestUrl = '$baseUrl/$id/despesas?ano=$year&mes=$month';

    try {
      final response = await http.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData != null &&
            responseData is Map &&
            responseData.containsKey('dados')) {
          final List<dynamic>? data = responseData['dados'];
          final List<ExpensesModel> expenses = [];

          if (data != null) {
            for (final item in data) {
              if (item is Map<String, dynamic>) {
                final expense = ExpensesModel.fromMap(item);
                // ignore: unnecessary_null_comparison
                if (expense != null) {
                  expenses.add(expense);
                }
              }
            }
          }
          return expenses;
        } else {
          return []; // Retorna uma lista vazia se não houver dados
        }
      } else {
        throw Exception('Erro ao carregar despesas: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar despesas: $e');
      throw Exception('Erro ao carregar despesas: $e');
    }
  }

  Future<List<ComissionModel>> getCommissions() async {
    final String requestUrl = baseUrlComission;
    List<ComissionModel> commissions = [];

    try {
      final response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData != null &&
            responseData is Map &&
            responseData.containsKey('dados')) {
          final List<dynamic>? data = responseData['dados'];

          if (data != null) {
            for (final item in data) {
              if (item is Map<String, dynamic>) {
                final commission = ComissionModel.fromJson(item);
                commissions.add(commission); // Adiciona a comissão à lista
              }
            }
          }
        } else {
          throw Exception(
              'Erro ao carregar comissões: dados não encontrados na resposta');
        }
      } else {
        throw Exception('Erro ao carregar comissões: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar comissões: $e');
      throw Exception('Erro ao carregar comissões: $e');
    }

    return commissions; // Retorna a lista de comissões
  }

  Future<ComissionDetailsModel> getCommissionDetails(int id) async {
    final String requestUrl =
        '$baseUrlComission/$id'; // Adicione o ID da comissão à URL de requisição

    try {
      final response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData != null &&
            responseData is Map &&
            responseData.containsKey('dados')) {
          final Map<String, dynamic> data = responseData['dados'];

          return ComissionDetailsModel.fromMap(
              data); // Retorna os detalhes da comissão convertidos para o modelo ComissionDetailsModel
        } else {
          throw Exception(
              'Erro ao carregar detalhes da comissão: dados não encontrados na resposta');
        }
      } else {
        throw Exception(
            'Erro ao carregar detalhes da comissão: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar detalhes da comissão: $e');
      throw Exception('Erro ao carregar detalhes da comissão: $e');
    }
  }

  Future<List<MembersComissionModel>> getCommissionMembers(int id) async {
    final String requestUrl = '$baseUrlComission/$id/membros';

    try {
      final response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData != null &&
            responseData is Map &&
            responseData.containsKey('dados')) {
          final List<dynamic> data = responseData['dados'];

          List<MembersComissionModel> members = data
              .map<MembersComissionModel>(
                  (memberJson) => MembersComissionModel.fromMap(memberJson))
              .toList();
          return members;
        } else {
          throw Exception(
              'Erro ao carregar membros da comissão: dados não encontrados na resposta');
        }
      } else {
        throw Exception(
            'Erro ao carregar membros da comissão: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar membros da comissão: $e');
      throw Exception('Erro ao carregar membros da comissão: $e');
    }
  }
}
