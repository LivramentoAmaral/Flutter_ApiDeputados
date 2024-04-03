import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/listDeputy');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).canvasColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 40), // Ajuste a altura aqui
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://evc.camara.leg.br/site/wp-content/uploads/2021/04/t_camara.png', // URL da imagem para deputados
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(
                        height:
                            5), // Ajuste o espaçamento entre a imagem e o texto
                    const Text(
                      'Lista de Deputados',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20), // Adicionando espaço entre os botões
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/partySearch');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).canvasColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 10), // Ajuste a altura aqui
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://media.moneytimes.com.br/uploads/2021/03/comissao-camara-dos-deputados-e1614714746393.jpg', // URL da imagem para comissões
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(
                        height:
                            5), // Ajuste o espaçamento entre a imagem e o texto
                    const Text(
                      'Lista de Comissões',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
