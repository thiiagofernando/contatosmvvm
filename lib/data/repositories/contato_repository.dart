import '../database/database_helper.dart';
import '../../domain/models/contato.dart';
import 'package:uuid/uuid.dart';

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
    contato.id = const Uuid().v4();
    await box.put(contato.id, contato.toMap());
  }

  Future<void> updateContato(Contato contato) async {
    final box = await _databaseHelper.box;
    await box.put(contato.id, contato.toMap());
  }

  Future<void> deleteContato(String id) async {
    final box = await _databaseHelper.box;
    await box.delete(id);
  }
}
