import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class DatabaseHelper {
  static Box<Map>? _box;
  static const String _boxName = 'contacts';

  Future<Box<Map>> get box async {
    if (_box != null) return _box!;
    _box = await _initBox();
    return _box!;
  }

  Future<Box<Map>> _initBox() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    return await Hive.openBox<Map>(_boxName);
  }

  Future<void> initializeDatabase() async {
    await Hive.initFlutter();
    await _initBox();
  }

  // Método para simular a criação da tabela (não é necessário com Hive, mas mantido para compatibilidade)
  Future<void> createTable() async {
    final box = await this.box;
    if (box.isEmpty) {
      await box.put('schema_version', {'version': 1});
    }
  }
}
