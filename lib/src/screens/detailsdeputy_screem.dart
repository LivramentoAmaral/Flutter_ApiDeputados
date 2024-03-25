import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_deputyapp/src/models/deputyid_model.dart';
import 'package:flutter_deputyapp/src/repositories/repositorydeputy.dart';

class DetailsDeputyPage extends StatelessWidget {
  const DetailsDeputyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtendo o ID do deputado passado como argumento
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
            // Formatar a data de nascimento para o padrão brasileiro
            final formattedBirthDate = DateFormat('dd/MM/yyyy')
                .format(DateTime.parse('${deputy.birthDate}'));

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(deputy.urlFoto ?? ''),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Informações Pessoais',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 10),
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
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Outras Informações',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'CPF: ${deputy.cpf}',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Data de nascimento: $formattedBirthDate', // Utilize a data formatada
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Escolaridade: ${deputy.education}',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
