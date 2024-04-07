import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_deputyapp/src/models/deputy_model.dart';
import 'package:flutter_deputyapp/src/repositories/repositorydeputy.dart';

class StateSearchPage extends StatefulWidget {
  const StateSearchPage({super.key});

  @override
  _StateSearchPageState createState() => _StateSearchPageState();
}

class _StateSearchPageState extends State<StateSearchPage> {
  final DeputyRepository _repository = DeputyRepository();
  List<DeputyModel> _deputies = [];
  final TextEditingController _stateController = TextEditingController();
  String _errorMessage = '';
  bool _loading = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadDeputies('');
  }

  @override
  void dispose() {
    _stateController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _viewDeputyDetails(DeputyModel deputy) {
    Navigator.pushNamed(
      context,
      '/details',
      arguments: deputy.id,
    );
  }

  Future<void> _loadDeputies(String query) async {
    setState(() {
      _loading = true;
      _errorMessage = ''; // Limpa a mensagem de erro ao iniciar a pesquisa
    });
    try {
      final deputies =
          await _repository.getDeputies(state: query.toUpperCase());
      if (mounted) {
        setState(() {
          _deputies = deputies;
          if (_deputies.isEmpty && query.isNotEmpty) {
            _errorMessage =
                'Nenhum deputado encontrado. Por favor, digite a sigla do estado corretamente (ex: SP, RJ, MG).';
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

  void _clearSearch() {
    setState(() {
      _deputies.clear();
    });
  }

  void _searchDeputies(String query) {
    query = query.toUpperCase();
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      await _loadDeputies(query);
      // Se a consulta estiver vazia, limpa a lista de deputados e carrega todos os deputados novamente
      if (query.isEmpty) {
        _clearSearch();
        _loadDeputies('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar por Sigla do Estado (UF)'),
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
                ? const Center(child: CircularProgressIndicator())
                : _deputies.isEmpty
                    ? Center(
                        child: _errorMessage.isNotEmpty
                            ? Text(
                                'Erro ao carregar deputados. $_errorMessage',
                                style: const TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              )
                            : const Text(
                                'Nenhum deputado encontrado.',
                                style: TextStyle(color: Colors.grey),
                              ),
                      )
                    : ListView.builder(
                        itemCount: _deputies.length,
                        itemBuilder: (context, index) {
                          final deputy = _deputies[index];
                          return ListTile(
                            title: Text(deputy.name),
                            subtitle: Text('${deputy.party} - ${deputy.state}'),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(deputy.photo),
                            ),
                            onTap: () {
                              _viewDeputyDetails(deputy);
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
