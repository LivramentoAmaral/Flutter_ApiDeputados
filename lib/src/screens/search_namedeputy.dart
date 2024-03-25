import 'dart:async';
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
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadDeputiesByName('');
  }

  @override
  void dispose() {
    _nameController.dispose();
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

  Future<void> _loadDeputiesByName(String name) async {
    setState(() {
      _loading = true;
      if (name.isNotEmpty) {
        _errorMessage = '';
      }
    });
    try {
      List<DeputyModel> deputies;
      if (name.isEmpty) {
        deputies = await _repository.getDeputies();
      } else {
        deputies = await _repository.getDeputies(name: name);
      }
      if (mounted) {
        setState(() {
          _deputies = deputies;
          if (_deputies.isEmpty && name.isNotEmpty) {
            _errorMessage =
                'Nenhum deputado encontrado. Por favor, digite o nome corretamente (ex: João, Maria, José).';
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
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _loadDeputiesByName(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisar por Nome do Deputado'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                : _deputies.isEmpty && _errorMessage.isNotEmpty
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
