import 'dart:async';
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
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadDeputiesByState('');
  }

  @override
  void dispose() {
    _stateController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _loadDeputiesByState(String state) async {
    setState(() {
      _loading = true;
      if (state.isNotEmpty) {
        _errorMessage = '';
      }
    });
    try {
      final deputies =
          await _repository.getDeputies(state: state.toUpperCase());
      if (mounted) {
        setState(() {
          _deputies = deputies;
          if (_deputies.isEmpty && state.isNotEmpty) {
            _errorMessage =
                'Nenhum deputado encontrado. Por favor, digite a sigla do estado corretamente (ex: SP, RJ, MG).';
          } else {
            _errorMessage =
                ''; // Limpa a mensagem de erro se deputados forem encontrados
          }
        });
      }
    } catch (e) {
      print('Erro ao carregar deputados: $e');
      if (mounted) {
        setState(() {
          _errorMessage =
              'Tente novamente'; // Define a mensagem de erro como "Tente novamente"
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  void _searchDeputies(String query) {
    query = query.toLowerCase();
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _loadDeputiesByState(query);
    });
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                : _deputies.isEmpty && _errorMessage.isNotEmpty
                    ? Center(
                        child: Text(
                          _errorMessage,
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : _deputies.isEmpty
                        ? Center(
                            child: Text(
                              'Erro ao carregar deputados. $_errorMessage',
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
      floatingActionButton: FloatingActionButton(
        onPressed: _clearSearch,
        child: Icon(Icons.clear),
      ),
    );
  }
}
