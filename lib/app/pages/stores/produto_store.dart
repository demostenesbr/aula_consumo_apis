import 'package:aula_consumo_apis/app/data/http/exceptions.dart';
import 'package:aula_consumo_apis/app/data/models/produto_model.dart';
import 'package:aula_consumo_apis/app/data/repositories/produto_repository.dart';
import 'package:flutter/material.dart';

class ProdutoStore {
  final IProdutoReposity repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<ProdutoModel>> state =
      ValueNotifier<List<ProdutoModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ProdutoStore({required this.repository});

  Future getProdutos() async {
    isLoading.value = true;

    try {
      final result = await repository.getProdutos();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}
