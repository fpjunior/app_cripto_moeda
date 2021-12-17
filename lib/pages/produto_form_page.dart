import 'package:flutter/material.dart';
import 'package:flutter_aula1/models/produto.dart';
import 'package:flutter_aula1/repositories/produto_repository.dart';
import 'package:provider/provider.dart';

class ProdutoForm extends StatelessWidget {
  // const ProdutoForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  final Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Produto'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _formKey.currentState!.validate();
              if (isValid) {
                _formKey.currentState!.save();
                Provider.of<ProdutoRepository>(context, listen: false).put(
                    Produto(
                        urlImage: _formData['urlImage'],
                        nome: _formData['nome'],
                        descricao: _formData['descricao'],
                        preco: 2212.6));
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value!.trim().isEmpty ||
                      value!.trim().length <= 3 ||
                      value == null) {
                    return 'Nome inválido';
                  }
                  return null;
                },
                onSaved: (value) => {
                  _formData['nome'] = value,
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                onSaved: (value) => {
                  _formData['descricao'] = value,
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preço'),
                onSaved: (value) => {
                  _formData['preco'] = value,
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Url Imagem'),
                onSaved: (value) => {
                  _formData['urlImage'] = value,
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text('Salvar'),
                      onPressed: () {},
                    ),
                    ElevatedButton(
                      child: Text('Cancelar'),
                      onPressed: () {},
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
