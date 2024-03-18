import 'package:flutter/material.dart';
import 'package:flutter_deputyapp/src/models/deputy_model.dart';

class DetailsDeputy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DeputyModel deputy = ModalRoute.of(context)!.settings.arguments as DeputyModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(deputy.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(deputy.photo),
            ),
            SizedBox(height: 20),
            Text(
              'Partido: ${deputy.party}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Estado: ${deputy.state}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Email: ${deputy.email}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Telefone: ${deputy.phone}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Endereço: ${deputy.address}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Rede Social: ${deputy.social}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Site: ${deputy.site}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Biografia: ${deputy.biography}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}