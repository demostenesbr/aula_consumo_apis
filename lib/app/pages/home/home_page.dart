import 'package:aula_consumo_apis/app/data/repositories/produto_repository.dart';
import 'package:aula_consumo_apis/app/pages/stores/produto_store.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProdutoStore store = ProdutoStore(
    repository: ProdutoRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text(
            'Consumo de APIs',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          store.isLoading,
          store.erro,
          store.state,
        ]),
        builder: (conetent, child) {
          if (store.isLoading.value) {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
