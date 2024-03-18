import 'package:flutter/material.dart';
import 'package:flutter_deputyapp/src/models/deputy_model.dart';
import 'package:flutter_deputyapp/src/models/deputyid_model.dart';
import 'package:flutter_deputyapp/src/repositories/repositorydeputy.dart';

class DetailsDeputy extends StatelessWidget {
  final DeputyRepository deputyRepository;
  final int deputyId;

  const DetailsDeputy({
    Key? key,
    required this.deputyRepository,
    required this.deputyId, required DeputyModel deputy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DeputyModelId>(
      future: deputyRepository.getDeputyById(deputyId),
      builder: (context, AsyncSnapshot<DeputyModelId> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Erro ao carregar deputado: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final DeputyModelId deputy = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: Text(deputy.nome),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CircleAvatar(
                  //   radius: 50,
                  //   backgroundImage: NetworkImage(deputy.photo),
                  // ),
                  SizedBox(height: 20),
                  Text(
                    'CPF: ${deputy.cpf ?? "CPF não disponível"}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Data de Falecimento: ${deputy.dataFalecimento ?? "Data de falecimento não disponível"}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Data de Nascimento: ${deputy.dataNascimento ?? "Data de nascimento não disponível"}',
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
