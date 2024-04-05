import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_deputyapp/src/models/deputyid_model.dart';
import 'package:flutter_deputyapp/src/models/expenses_model.dart';
import 'package:flutter_deputyapp/src/repositories/repositorydeputy.dart';

class DetailsDeputyPage extends StatefulWidget {
  const DetailsDeputyPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DetailsDeputyPageState createState() => _DetailsDeputyPageState();
}

class _DetailsDeputyPageState extends State<DetailsDeputyPage> {
  int? _selectedMonth;
  int? _selectedYear;
  List<ExpensesModel>? _expenses;

  final List<String> _months = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro'
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAllExpenses();
  }

  Future<void> _loadAllExpenses() async {
    final int deputyId = ModalRoute.of(context)?.settings.arguments as int;
    _expenses = await DeputyRepository().getAllExpenses(deputyId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Deputado'),
      ),
      body: FutureBuilder<ParliamentarianDetails>(
        future: DeputyRepository().getParliamentarianDetails(
          ModalRoute.of(context)?.settings.arguments as int,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar deputado: ${snapshot.error}',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            final deputy = snapshot.data!;
            final formattedBirthDate = DateFormat('dd/MM/yyyy')
                .format(DateTime.parse('${deputy.birthDate}'));

            double totalExpenses = _calculateTotalExpenses();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      // Informações pessoais
                      Center(
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(deputy.urlFoto ?? ''),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                      const SizedBox(height: 10),
                      // Dados pessoais do deputado
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nome: ${deputy.nickname}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Partido: ${deputy.party}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Sexo: ${deputy.sex == 'M' ? 'Masculino' : 'Feminino'}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                'CPF: ${deputy.cpf}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Data de nascimento: $formattedBirthDate',
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Escolaridade: ${deputy.education}',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Despesas
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                      const SizedBox(height: 10),
                      // Filtros de mês e ano
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButton<String>(
                                hint: const Text('Selecione o mês'),
                                value: _selectedMonth != null
                                    ? _months[_selectedMonth! - 1]
                                    : null,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedMonth =
                                        _months.indexOf(newValue!) + 1;
                                    _updateExpensesIfNeeded();
                                  });
                                },
                                items: _months.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(width: 10),
                              DropdownButton<int>(
                                hint: const Text('Selecione o ano'),
                                value: _selectedYear,
                                onChanged: (int? newValue) {
                                  setState(() {
                                    _selectedYear = newValue;
                                    _updateExpensesIfNeeded();
                                  });
                                },
                                items: List.generate(
                                  10,
                                  (index) => DateTime.now().year - index,
                                ).map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text('$value'),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Total das despesas
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Valor Total das despesas: ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            'R\$ ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            // ignore: unnecessary_string_interpolations
                            "${totalExpenses.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      // Lista de despesas
                      SizedBox(
                        height: 150,
                        child: _expenses != null
                            ? _expenses!.isEmpty
                                ? const Center(
                                    child: Text(
                                      'Nenhuma despesa encontrada.',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _expenses!.length,
                                    itemBuilder: (context, index) {
                                      if (_expenses!.isEmpty) {
                                        return const Center(
                                          child: Text(
                                            'Sem despesas no período',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        );
                                      } else {
                                        final expense = _expenses![index];
                                        final formattedDate =
                                            DateFormat('dd/MM/yyyy').format(
                                          DateTime.parse(expense.dataDocumento),
                                        );
                                        return Container(
                                          margin: const EdgeInsets.only(
                                            right: 8,
                                            bottom: 8,
                                            top: 8,
                                            left: 10,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Descrição: ${expense.tipoDespesa}',
                                                style: const TextStyle(
                                                        fontSize: 16)
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              _formatExpenseValue(
                                                  expense.valorLiquido),
                                              Text(
                                                  'Tipo da despesa: ${expense.tipoDespesa} '),
                                              Text(
                                                  'Data do Documento: $formattedDate')
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  )
                            : const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          _selectedMonth = null;
                          _selectedYear = null;
                          await _loadAllExpenses(); // Carregar todas as despesas
                        },
                        child: const Text('Listar todas'),
                      ),
                      const SizedBox(height: 20), // Espaçamento após os botões
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
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

  Future<void> _updateExpensesIfNeeded() async {
    final int deputyId = ModalRoute.of(context)?.settings.arguments as int;
    if (_selectedMonth != null && _selectedYear != null) {
      await _updateExpenses(deputyId, _selectedYear!, _selectedMonth!);
    }
  }

  Future<void> _updateExpenses(int deputyId, int year, int month) async {
    try {
      final List<ExpensesModel> updatedExpenses = await DeputyRepository()
          .getExpensesByMonthAndYear(deputyId, year, month);
      setState(() {
        _expenses = updatedExpenses;
      });
    } catch (e) {
      // ignore: avoid_print
      print('Erro ao atualizar despesas: $e');
      // Trate o erro conforme necessário
    }
  }

  Widget _formatExpenseValue(double? value) {
    if (value != null) {
      String stringValue = value.toStringAsFixed(
          2); // Formata o valor para ter sempre duas casas decimais após o ponto
      List<String> parts = stringValue.split('.');
      if (parts.length > 1) {
        if (parts[1].length == 1) {
          return RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black, // Cor do texto "Valor Líquido:"
              ),
              children: [
                const TextSpan(
                    text: 'Valor Líquido: '), // Texto "Valor Líquido:"
                TextSpan(
                  text:
                      'R\$ ${parts[0]}.${parts[1]}0', // Adicionando "R\$" antes do valor
                  style: const TextStyle(
                    color: Colors.greenAccent, // Cor do valor
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }
      }
      return RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black, // Cor do texto "Valor Líquido:"
          ),
          children: [
            const TextSpan(text: 'Valor Líquido: '), // Texto "Valor Líquido:"
            TextSpan(
              text: 'R\$ $stringValue', // Adicionando "R\$" antes do valor
              style: const TextStyle(
                color: Colors.greenAccent, // Cor do valor
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
    return const Text(
      'Valor Líquido: R\$ 0.00',
      style: TextStyle(
        color: Colors.black, // Cor do texto "Valor Líquido:"
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  double _calculateTotalExpenses() {
    double total = 0;
    if (_expenses != null) {
      for (var expense in _expenses!) {
        total += expense.valorLiquido;
      }
    }
    return total;
  }
}
