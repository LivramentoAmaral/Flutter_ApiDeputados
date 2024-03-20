import 'package:flutter/material.dart';
import 'package:flutter_deputyapp/src/models/deputy_model.dart';
import 'package:flutter_deputyapp/src/repositories/repositorydeputy.dart';

class PartySearchPage extends StatefulWidget {
  @override
  _PartySearchPageState createState() => _PartySearchPageState();
}

class _PartySearchPageState extends State<PartySearchPage> {
  final DeputyRepository _repository = DeputyRepository();
  List<DeputyModel> _deputies = [];
  TextEditingController _partyController = TextEditingController();
  String _errorMessage = '';
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadDeputies('');
  }

  Future<void> _loadDeputies(String query) async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });
    try {
      final deputies =
          await _repository.getDeputies(party: query.toLowerCase());
      setState(() {
        _deputies = deputies;
        if (_deputies.isEmpty) {
          _errorMessage =
              'Nenhum deputado encontrado por favor digite a sigla do partido corretamente ex: pt, psdb, mdb.';
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
    if (query.isEmpty) {
      _loadDeputies('');
    } else {
      _loadDeputies(query);
    }
  }

  void _clearSearch() {
    _partyController.clear();
    _loadDeputies('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisar por Sigla do Partido'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _partyController,
                onChanged: _searchDeputies,
                decoration: const InputDecoration(
                  labelText: 'Sigla do Partido',
                  hintText: 'Ex: PT, PSDB, MDB...',
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
