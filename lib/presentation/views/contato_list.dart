import 'package:contatosmvvm/domain/models/contato.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/contato_viewmodel.dart';
import '../widgets/contato_form_dialog.dart';

class ContatoListView extends StatefulWidget {
  const ContatoListView({super.key});

  @override
  ContatoListViewState createState() => ContatoListViewState();
}

class ContatoListViewState extends State<ContatoListView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<ContatoViewModel>(context, listen: false).loadContatos();
      }
    });
  }

  void _handleSearch(BuildContext context) {
    final viewModel = Provider.of<ContatoViewModel>(context, listen: false);
    if (_searchController.text.isEmpty) {
      viewModel.loadContatos(); // Recarrega todos os contatos
    } else {
      viewModel.searchContatos(_searchController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contatos')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              spacing: 10,
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Informe o nome',
                    ),
                    onChanged: (value) {
                      setState(() {});
                      if (value.isEmpty) {
                        _handleSearch(context);
                      }
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _handleSearch(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Buscar'),
                ),
                ElevatedButton(
                  onPressed: () => _showContatoDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text('Novo'),
                )
              ],
            ),
          ),
          Expanded(
            child: Consumer<ContatoViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: viewModel.contatos.length,
                  itemBuilder: (context, index) {
                    final contatoModel = viewModel.contatos[index];
                    return ListTile(
                      title: Text(contatoModel.nome),
                      subtitle: Text('${contatoModel.email}\n${contatoModel.telefone}'),
                      onTap: () => _showContatoDialog(context, contatoModel),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showContatoDialog(BuildContext context, [Contato? cont]) {
    showDialog(
      context: context,
      builder: (context) => ContatoFormDialog(contato: cont),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
