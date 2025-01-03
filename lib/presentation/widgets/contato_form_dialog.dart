import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/models/contato.dart';
import '../viewmodels/contato_viewmodel.dart';

class ContatoFormDialog extends StatefulWidget {
  final Contato? contato;

  const ContatoFormDialog({
    super.key,
    this.contato,
  });

  @override
  ContatoFormDialogState createState() => ContatoFormDialogState();
}

class ContatoFormDialogState extends State<ContatoFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contato?.nome);
    _emailController = TextEditingController(text: widget.contato?.email);
    _phoneController = TextEditingController(text: widget.contato?.telefone);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.contato == null ? 'Novo Contato' : 'Editar Contato'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                keyboardType: TextInputType.name,
                validator: (value) => value?.isEmpty ?? true ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value?.isEmpty ?? true ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
                validator: (value) => value?.isEmpty ?? true ? 'Campo obrigatório' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        Visibility(
          visible: widget.contato != null,
          child: TextButton(
            onPressed: _deleteContato,
            child: const Text('Excluir'),
          ),
        ),
        ElevatedButton(
          onPressed: _saveContato,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: Text(widget.contato == null ? 'Salvar' : 'Alterar'),
        ),
      ],
    );
  }

  void _deleteContato() {
    Provider.of<ContatoViewModel>(context, listen: false).removeContato(widget.contato?.id ?? "");
    Navigator.pop(context);
  }

  void _saveContato() {
    if (_formKey.currentState?.validate() ?? false) {
      final contatoModel = Contato(
        id: widget.contato?.id,
        nome: _nameController.text,
        email: _emailController.text,
        telefone: _phoneController.text,
      );

      if (widget.contato == null) {
        Provider.of<ContatoViewModel>(context, listen: false).addContato(contatoModel);
      } else {
        Provider.of<ContatoViewModel>(context, listen: false).updateContato(contatoModel);
      }

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
