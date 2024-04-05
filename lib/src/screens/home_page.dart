import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/listDeputy');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).canvasColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder(
                      future: precacheImage(
                        Image.network(
                          'https://evc.camara.leg.br/site/wp-content/uploads/2021/04/t_camara.png', // URL da imagem para deputados
                          width: 200,
                          height: 200,
                        ).image,
                        context,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Mostra um indicador de carregamento enquanto a imagem está sendo carregada
                        } else if (snapshot.hasError) {
                          return const Text(
                              'Sem conexão'); // Exibe uma mensagem de erro se não for possível carregar a imagem
                        } else {
                          return Image.network(
                            'https://evc.camara.leg.br/site/wp-content/uploads/2021/04/t_camara.png',
                            width: 200,
                            height: 200,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    const Icon(
                      Icons.arrow_forward,
                    ), // Adicionando o ícone da seta
                    const SizedBox(height: 5),
                    const Text(
                      'Lista de Deputados',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Adicionando espaço entre os botões
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/comissions');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).canvasColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder(
                      future: precacheImage(
                        Image.network(
                          'https://media.moneytimes.com.br/uploads/2021/03/comissao-camara-dos-deputados-e1614714746393.jpg', // URL da imagem para comissões
                          width: 200,
                          height: 200,
                        ).image,
                        context,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Mostra um indicador de carregamento enquanto a imagem está sendo carregada
                        } else if (snapshot.hasError) {
                          return const Text(
                              'Sem conexão'); // Exibe uma mensagem de erro se não for possível carregar a imagem
                        } else {
                          return Image.network(
                            'https://media.moneytimes.com.br/uploads/2021/03/comissao-camara-dos-deputados-e1614714746393.jpg',
                            width: 200,
                            height: 200,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    const Icon(
                      Icons.arrow_forward,
                    ), // Adicionando o ícone da seta
                    const SizedBox(height: 5),
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
