import 'package:flutter/material.dart';
import 'package:flutter_deputyapp/src/models/deputyid_model.dart';
import 'package:flutter_deputyapp/src/repositories/repositorydeputy.dart';

class DetailsDeputy extends StatelessWidget {
  final DeputyRepository deputyRepository;
  final int deputyId;

  const DetailsDeputy({
    Key? key,
    required this.deputyRepository,
    required this.deputyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ParliamentarianDetails>(
      future: deputyRepository.getParliamentarianDetails(deputyId),
      builder: (context, AsyncSnapshot<ParliamentarianDetails> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Erro ao carregar deputado: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final ParliamentarianDetails deputy = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: Text(deputy.civilName ?? ''),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'CPF: ${deputy.cpf ?? "CPF não disponível"}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Data de Falecimento: ${deputy.deathDate ?? "Data de falecimento não disponível"}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Data de Nascimento: ${deputy.birthDate ?? "Data de nascimento não disponível"}',
                    style: TextStyle(fontSize: 18),
                  ),
                  // Continue adicionando os outros campos conforme necessário
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Text('Nenhum dado disponível'),
          );
        }
      },
    );
  }
}
