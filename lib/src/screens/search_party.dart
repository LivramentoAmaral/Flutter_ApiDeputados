import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_deputyapp/src/models/deputy_model.dart';
import 'package:flutter_deputyapp/src/repositories/repositorydeputy.dart';

class PartySearchPage extends StatefulWidget {
  const PartySearchPage({super.key});

  @override
  _PartySearchPageState createState() => _PartySearchPageState();
}

class _PartySearchPageState extends State<PartySearchPage> {
  final DeputyRepository _repository = DeputyRepository();
  List<DeputyModel> _deputies = [];
  final TextEditingController _partyController = TextEditingController();
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
    _partyController.dispose();
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
      if (query.isNotEmpty) {
        _errorMessage = '';
      }
    });
    try {
      List<DeputyModel> deputies;
      if (query.isEmpty) {
        deputies = await _repository.getDeputies();
      } else {
        deputies = await _repository.getDeputies(party: query.toLowerCase());
      }
      if (mounted) {
        setState(() {
          _deputies = deputies;
          if (_deputies.isEmpty && query.isNotEmpty) {
            _errorMessage =
                'Nenhum deputado encontrado. Por favor, digite a sigla do partido corretamente (ex: PT, PSDB, MDB).';
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
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      await _loadDeputies(query);
      if (mounted) { // Verifica se o widget está montado
        // Verifica se os resultados contêm a consulta atual
        List<DeputyModel> filteredDeputies = _deputies.where((deputy) {
          return deputy.party.toLowerCase().contains(query);
        }).toList();
        setState(() {
          _deputies = filteredDeputies;
        });

        // Se a consulta estiver vazia, limpa a lista de deputados e carrega todos os deputados novamente
        if (query.isEmpty) {
          _clearSearch();
          _loadDeputies('');
        }
      }
    });
  }

  void _clearSearch() {
    setState(() {
      _deputies.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar por Sigla do Partido'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                ? const Center(child: CircularProgressIndicator())
                : _deputies.isEmpty && _errorMessage.isNotEmpty
                    ? Center(
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : _deputies.isEmpty
                        ? Center(
                            child: Text(
                              'Erro ao carregar deputados. $_errorMessage',
                              style: const TextStyle(color: Colors.red),
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
