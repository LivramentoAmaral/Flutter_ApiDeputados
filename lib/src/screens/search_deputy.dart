import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Busca'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: ListTile(
                title: Text('Pesquisar por Sigla do Partido'),
                onTap: () {
                  Navigator.pushNamed(context, '/partySearch');
                },
              ),
            ),
            SizedBox(height: 20),
            Card(
              child: ListTile(
                title: Text('Pesquisar por Sigla do UF'),
                onTap: () {
                  Navigator.pushNamed(context, '/stateSearch');
                },
              ),
            ),
            SizedBox(height: 20),
            Card(
              child: ListTile(
                title: Text('Pesquisar por Nome'),
                onTap: () {
                  Navigator.pushNamed(context, '/nameSearch');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
