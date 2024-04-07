import 'package:flutter/material.dart';
import 'package:flutter_deputyapp/src/models/deputy_model.dart';
import 'package:flutter_deputyapp/src/repositories/repositorydeputy.dart';

class ListDeputy extends StatefulWidget {
  const ListDeputy({Key? key}) : super(key: key);

  @override
  _ListDeputyState createState() => _ListDeputyState();
}

class _ListDeputyState extends State<ListDeputy> {
  final DeputyRepository _repository = DeputyRepository();
  List<DeputyModel> _deputies = [];
  List<DeputyModel> _filteredDeputies = [];
  bool _isLoading = true;

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
        _isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar deputados: $e');
    }
  }

  void _viewDeputyDetails(DeputyModel deputy) {
    Navigator.pushNamed(
      context,
      '/details',
      arguments: deputy.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista dos Deputados'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(), // Indicador de carregamento
            )
          : ListView.builder(
              itemCount: _filteredDeputies.length,
              itemBuilder: (context, index) {
                final deputy = _filteredDeputies[index];
                return ListTile(
                  onTap: () => _viewDeputyDetails(deputy),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(deputy.photo),
                  ),
                  title: Text(deputy.name),
                  subtitle: Text('${deputy.party} - ${deputy.state}'),
                );
              },
            ),
    );
  }
}
