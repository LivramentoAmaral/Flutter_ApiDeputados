import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página de Busca'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: ListTile(
                title: const Text('Pesquisar por Sigla do Partido'),
                onTap: () {
                  Navigator.pushNamed(context, '/partySearch');
                },
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                title: const Text('Pesquisar por Sigla do UF'),
                onTap: () {
                  Navigator.pushNamed(context, '/stateSearch');
                },
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                title: const Text('Pesquisar por Nome'),
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
