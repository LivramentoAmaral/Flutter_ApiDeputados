import 'package:flutter/material.dart';
import 'package:flutter_deputyapp/src/models/deputy_model.dart';
import 'package:flutter_deputyapp/src/repositories/repositorydeputy.dart';

class DeputyListPage extends StatefulWidget {
  @override
  _DeputyListPageState createState() => _DeputyListPageState();
}

class _DeputyListPageState extends State<DeputyListPage> {
  final DeputyRepository _repository = DeputyRepository();
  List<DeputyModel> _deputies = [];
  List<DeputyModel> _filteredDeputies = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDeputies();
  }

  Future<void> _loadDeputies() async {
    try {
      final deputies = await _repository.getDeputies();
      setState(() {
        _deputies = deputies;
        _filteredDeputies = deputies;
      });
    } catch (e) {
      print('Erro ao carregar deputados: $e');
    }
  }

  void _searchDeputies(String query) {
    setState(() {
      _filteredDeputies = _deputies.where((deputy) {
        final name = deputy.name.toLowerCase();
        final party = deputy.party.toLowerCase();
        final state = deputy.state.toLowerCase();
        final lowerCaseQuery = query.toLowerCase();

        return name.contains(lowerCaseQuery) ||
            party.contains(lowerCaseQuery) ||
            state.contains(lowerCaseQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Deputados'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _searchDeputies,
              decoration: InputDecoration(
                labelText: 'Pesquisar',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredDeputies.length,
              itemBuilder: (context, index) {
                final deputy = _filteredDeputies[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(deputy.photo),
                  ),
                  title: Text(deputy.name),
                  subtitle: Text(deputy.party),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DeputyListPage(),
  ));
}
