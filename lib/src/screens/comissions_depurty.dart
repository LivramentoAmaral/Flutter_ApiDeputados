import 'package:flutter/material.dart';
import 'package:flutter_deputyapp/src/models/commission_model.dart';
import 'package:flutter_deputyapp/src/repositories/repositorydeputy.dart';

class ComissionsPage extends StatefulWidget {
  @override
  _ComissionsPageState createState() => _ComissionsPageState();
}

class _ComissionsPageState extends State<ComissionsPage> {
  List<ComissionModel> commissions = [];

  @override
  void initState() {
    super.initState();
    fetchCommissions();
  }

  Future<void> fetchCommissions() async {
    try {
      final List<ComissionModel> fetchedCommissions =
          await DeputyRepository().getCommissions();

      setState(() {
        commissions = fetchedCommissions;
      });
    } catch (e) {
      print('Erro ao carregar comissões: $e');
      // Aqui você pode exibir um SnackBar ou uma mensagem de erro para o usuário
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Comissões'),
      ),
      body: commissions.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: commissions.length,
              itemBuilder: (context, index) {
                final commission = commissions[index];
                return Card(
                  elevation: 3, // Adiciona sombra ao card
                  margin: EdgeInsets.all(8), // Define margem ao redor do card
                  child: ListTile(
                    leading: Icon(Icons.people), // Ícone para cada comissão
                    title: Text(commission.titulo),
                  ),
                );
              },
            ),
    );
  }
}
