import 'package:flutter/material.dart';
import 'package:flutter_deputyapp/src/models/comission_details_model.dart';
import 'package:flutter_deputyapp/src/models/members_comission_model.dart';
import 'package:flutter_deputyapp/src/repositories/repositorydeputy.dart';

class ComissionDetailsPage extends StatelessWidget {
  const ComissionDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes da Comissão'),
        ),
        body: FutureBuilder<ComissionDetailsModel>(
          future: DeputyRepository().getCommissionDetails(
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
                  'Erro ao carregar comissão: ${snapshot.error}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              final comission = snapshot.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            comission.coordinator.urlFoto ?? '',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nome: ${comission.coordinator.nome}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Partido: ${comission.coordinator.siglaPartido}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Estado: ${comission.coordinator.siglaUf}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Email: ${comission.coordinator.email ?? "Não fornecido"}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Informações da Comissão',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Titulo: ${comission.titulo}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Situação: ${comission.situacao}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      'Telefone: ${comission.telefone}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Botão flutuante centralizado com uma seta
                      Align(
                        alignment: Alignment.center,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.arrow_drop_up),
                                      ),
                                      Expanded(
                                        child: FutureBuilder<
                                            List<MembersComissionModel>>(
                                          future: DeputyRepository()
                                              .getCommissionMembers(
                                                  comission.id),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                  'Erro ao carregar membros da comissão: ${snapshot.error}',
                                                  style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              );
                                            } else if (snapshot.hasData) {
                                              final List<MembersComissionModel>
                                                  members = snapshot.data!;
                                              return ListView.builder(
                                                itemCount: members.length,
                                                itemBuilder: (context, index) {
                                                  MembersComissionModel member =
                                                      members[index];
                                                  return ListTile(
                                                    title: Text(member.nome),
                                                    subtitle: Text(
                                                        member.siglaPartido),
                                                    leading: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                              member.urlFoto),
                                                    ),
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                        context,
                                                        '/details',
                                                        arguments: member.id,
                                                      );
                                                    },
                                                  );
                                                },
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
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          label: Text('Membros da Comissão'),
                          icon: Icon(Icons.arrow_drop_down),
                        ),
                      ),
                    ],
                  ),
                ),
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
        ));
  }
}
