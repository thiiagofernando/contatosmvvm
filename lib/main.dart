import 'package:contatosmvvm/data/database/database_helper.dart';
import 'package:contatosmvvm/presentation/viewmodels/contato_viewmodel.dart';
import 'package:contatosmvvm/presentation/views/contato_list.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final databaseHelper = DatabaseHelper();
  await databaseHelper.initializeDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContatoViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Contatos App',
        theme: ThemeData(
          primarySwatch: Colors.red,
          useMaterial3: false,
        ),
        home: const ContatoListView(),
      ),
    );
  }
}
