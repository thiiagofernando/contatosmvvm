import 'package:flutter/material.dart';
import '../../data/repositories/contato_repository.dart';
import '../../domain/models/contato.dart';

class ContatoViewModel extends ChangeNotifier {
  final ContatoRepository _repository = ContatoRepository();
  List<Contato> contatos = [];
  bool isLoading = false;

  Future<void> loadContatos() async {
    isLoading = true;
    notifyListeners();
    contatos = await _repository.getAllContatos();
    isLoading = false;
    notifyListeners();
  }

  Future<void> searchContatos(String nome) async {
    isLoading = true;
    notifyListeners();
    contatos = await _repository.searchContatos(nome);
    isLoading = false;
    notifyListeners();
  }

  Future<void> addContato(Contato contato) async {
    await _repository.insertContato(contato);
    await loadContatos();
  }

  Future<void> updateContato(Contato contato) async {
    await _repository.updateContato(contato);
    await loadContatos();
  }
}