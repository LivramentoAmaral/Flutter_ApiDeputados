import 'package:flutter/material.dart';
import 'package:flutter_deputyapp/src/models/deputy_model.dart';
import 'package:flutter_deputyapp/src/repositories/repositorydeputy.dart';

class NameSearchPage extends StatefulWidget {
  @override
  _NameSearchPageState createState() => _NameSearchPageState();
}

class _NameSearchPageState extends State<NameSearchPage> {
  final DeputyRepository _repository = DeputyRepository();
  List<DeputyModel> _deputies = [];
  TextEditingController _nameController = TextEditingController();
  String _errorMessage = '';
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadDeputiesByName('');
  }

  Future<void> _loadDeputiesByName(String name) async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });
    try {
      final deputies = await _repository.getDeputies(name: name);
      setState(() {
        _deputies = deputies;
        if (_deputies.isEmpty) {
          _errorMessage =
              'Nenhum deputado encontrado por favor digite o nome corretamente ex:joão, maria, josé.';
        }
      });
    } catch (e) {
      print('Erro ao carregar deputados: $e');
      setState(() {
        _errorMessage = 'Erro ao carregar deputados.';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _searchDeputies(String query) {
    _loadDeputiesByName(query);
  }

  void _clearSearch() {
    _nameController.clear();
    _loadDeputiesByName('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisar por Nome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _nameController,
                onChanged: _searchDeputies,
                decoration: const InputDecoration(
                  labelText: 'Nome do Deputado',
                  hintText: 'Ex: João, Maria...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: _loading
                  ? Center(child: CircularProgressIndicator())
                  : _deputies.isEmpty
                      ? Center(
                          child: Text(
                            _errorMessage,
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          itemCount: _deputies.length,
                          itemBuilder: (context, index) {
                            final deputy = _deputies[index];
                            return ListTile(
                              title: Text(deputy.name),
                              subtitle:
                                  Text('${deputy.party} - ${deputy.state}'),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(deputy.photo),
                              ),
                              onTap: () {
                                // Implemente a navegação para os detalhes do deputado aqui
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _clearSearch,
        child: Icon(Icons.clear),
      ),
    );
  }
}
