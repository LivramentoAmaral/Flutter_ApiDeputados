import 'package:flutter/material.dart';
import 'package:flutter_deputyapp/src/models/deputy_model.dart';
import 'package:flutter_deputyapp/src/repositories/repositorydeputy.dart';

class StateSearchPage extends StatefulWidget {
  @override
  _StateSearchPageState createState() => _StateSearchPageState();
}

class _StateSearchPageState extends State<StateSearchPage> {
  final DeputyRepository _repository = DeputyRepository();
  List<DeputyModel> _deputies = [];
  TextEditingController _stateController = TextEditingController();
  String _errorMessage = '';
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadDeputiesByState('');
  }

  Future<void> _loadDeputiesByState(String state) async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });
    try {
      final deputies =
          await _repository.getDeputies(state: state.toUpperCase());
      setState(() {
        _deputies = deputies;
        if (_deputies.isEmpty) {
          _errorMessage =
              'Nenhum deputado encontrado por favor dgite a sigla do estado ex: SP, PI,BA.';
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
    _loadDeputiesByState(query);
  }

  void _clearSearch() {
    _stateController.clear();
    _loadDeputiesByState('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisar por Sigla do Estado (UF)'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _stateController,
                onChanged: _searchDeputies,
                decoration: const InputDecoration(
                  labelText: 'Sigla do Estado (UF)',
                  hintText: 'Ex: SP, RJ, MG...',
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
