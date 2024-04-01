import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_deputyapp/src/models/deputyid_model.dart';
import 'package:flutter_deputyapp/src/models/expenses_model.dart';
import 'package:flutter_deputyapp/src/repositories/repositorydeputy.dart';

class DetailsDeputyPage extends StatefulWidget {
  const DetailsDeputyPage({Key? key}) : super(key: key);

  @override
  _DetailsDeputyPageState createState() => _DetailsDeputyPageState();
}

class _DetailsDeputyPageState extends State<DetailsDeputyPage> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final int deputyId = ModalRoute.of(context)?.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Deputado'),
      ),
      body: FutureBuilder<ParliamentarianDetails>(
        future: DeputyRepository().getParliamentarianDetails(deputyId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar deputado: ${snapshot.error}',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            final deputy = snapshot.data!;
            final formattedBirthDate = DateFormat('dd/MM/yyyy')
                .format(DateTime.parse('${deputy.birthDate}'));

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(deputy.urlFoto ?? ''),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Informações Pessoais',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nome: ${deputy.nickname}',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Partido: ${deputy.party}',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Sexo: ${deputy.sex == 'M' ? 'Masculino' : 'Feminino'}',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'CPF: ${deputy.cpf}',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Data de nascimento: $formattedBirthDate',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Escolaridade: ${deputy.education}',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Despesas',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 150,
                        child: FutureBuilder<List<ExpensesModel>>(
                          future: _selectedDate != null
                              ? DeputyRepository().getExpenses(
                                  deputyId,
                                  _selectedDate!.year,
                                  _selectedDate!.month,
                                )
                              : DeputyRepository().getAllExpenses(deputyId),
                          builder: (context, expensesSnapshot) {
                            if (expensesSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (expensesSnapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Erro ao carregar despesas: ${expensesSnapshot.error}',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                  ),
                                ),
                              );
                            } else if (expensesSnapshot.hasData) {
                              final List<ExpensesModel> expenses =
                                  expensesSnapshot.data!;
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: expenses.length,
                                itemBuilder: (context, index) {
                                  final expense = expenses[index];
                                  return Container(
                                    margin: EdgeInsets.only(
                                        right: 8, bottom: 8, top: 8, left: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Descrição: ${expense.tipoDespesa ?? 'Não especificado'}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          'Valor: ${expense.valorLiquido ?? 'Não especificado'}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                            'Tipo da despesa: ${expense.tipoDespesa ?? 'Não especificado'}'),
                                        Text(
                                            'Data do Documento: ${expense.dataDocumento ?? 'Não especificado'}')
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: Text(
                                  'Nenhuma despesa disponível',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text(
                'Nenhum dado disponível',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
