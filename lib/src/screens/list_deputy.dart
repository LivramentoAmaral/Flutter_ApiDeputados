import 'package:flutter/material.dart';
import 'package:flutter_deputyapp/src/models/deputy_model.dart';
import 'package:flutter_deputyapp/src/repositories/repositorydeputy.dart';

class ListDeputy extends StatefulWidget {
  const ListDeputy({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListDeputyState createState() => _ListDeputyState();
}

class _ListDeputyState extends State<ListDeputy> {
  final DeputyRepository _repository = DeputyRepository();
  // ignore: unused_field
  List<DeputyModel> _deputies = [];
  List<DeputyModel> _filteredDeputies = [];

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
      // ignore: avoid_print
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

  void _navigateToSearchPage() {
    Navigator.pushNamed(
      context,
      '/search',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deputados'),
      ),
      body: ListView.builder(
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
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: _navigateToSearchPage,
                child: const Text(
                  'Ir para a Página de Busca',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
