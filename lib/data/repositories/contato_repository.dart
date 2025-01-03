import '../database/database_helper.dart';
import '../../domain/models/contato.dart';

class ContatoRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<Contato>> getAllContatos() async {
    final box = await _databaseHelper.box;
    return box.values.map((e) => Contato.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  Future<List<Contato>> searchContatos(String nome) async {
    final box = await _databaseHelper.box;
    return box.values
        .where((e) => e['nome'].toString().toLowerCase().contains(nome.toLowerCase()))
        .map((e) => Contato.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> insertContato(Contato contato) async {
    final box = await _databaseHelper.box;
    await box.add(contato.toMap());
  }

  Future<void> updateContato(Contato contato) async {
    final box = await _databaseHelper.box;
    final index = box.values.toList().indexWhere((e) => e['id'] == contato.id);
    if (index != -1) {
      await box.putAt(index, contato.toMap());
    }
  }

  Future<void> deleteContato(int id) async {
    final box = await _databaseHelper.box;
    final index = box.values.toList().indexWhere((e) => e['id'] == id);
    if (index != -1) {
      await box.deleteAt(index);
    }
  }
}
