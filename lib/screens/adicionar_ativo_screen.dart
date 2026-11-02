import 'package:flutter/material.dart';

import '../models/ativo.dart';

/// Formulário para cadastrar um novo ativo.
/// Ao salvar, devolve o Ativo para a tela anterior via Navigator.pop.
class AdicionarAtivoScreen extends StatefulWidget {
  const AdicionarAtivoScreen({super.key});

  @override
  State<AdicionarAtivoScreen> createState() => _AdicionarAtivoScreenState();
}

class _AdicionarAtivoScreenState extends State<AdicionarAtivoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tickerController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _precoController = TextEditingController();
  TipoAtivo _tipoSelecionado = TipoAtivo.acao;

  // Controllers precisam ser liberados quando a tela é destruída.
  @override
  void dispose() {
    _tickerController.dispose();
    _quantidadeController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  /// Aceita tanto "10,50" quanto "10.50".
  double? _lerNumero(String texto) {
    return double.tryParse(texto.trim().replaceAll(',', '.'));
  }

  String? _validarNumero(String? valor) {
    if (valor == null || valor.trim().isEmpty) return 'Campo obrigatório';
    final numero = _lerNumero(valor);
    if (numero == null) return 'Digite um número válido';
    if (numero <= 0) return 'O valor deve ser maior que zero';
    return null;
  }

  void _salvar() {
    // validate() roda o validator de todos os campos do Form.
    if (!_formKey.currentState!.validate()) return;

    final ativo = Ativo(
      ticker: _tickerController.text.trim().toUpperCase(),
      quantidade: _lerNumero(_quantidadeController.text)!,
      precoMedio: _lerNumero(_precoController.text)!,
      tipo: _tipoSelecionado,
    );

    Navigator.pop(context, ativo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar ativo')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _tickerController,
              decoration: const InputDecoration(
                labelText: 'Ticker',
                hintText: 'Ex: PETR4',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.characters,
              validator: (valor) => (valor == null || valor.trim().isEmpty)
                  ? 'Informe o ticker'
                  : null,
            ),
            const SizedBox(height: 16),
            Text('Tipo', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: TipoAtivo.values.map((tipo) {
                return ChoiceChip(
                  label: Text(tipo.label),
                  selected: _tipoSelecionado == tipo,
                  onSelected: (_) => setState(() => _tipoSelecionado = tipo),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _quantidadeController,
              decoration: const InputDecoration(
                labelText: 'Quantidade',
                border: OutlineInputBorder(),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: _validarNumero,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _precoController,
              decoration: const InputDecoration(
                labelText: 'Preço médio',
                prefixText: 'R\$ ',
                border: OutlineInputBorder(),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: _validarNumero,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _salvar,
              icon: const Icon(Icons.check),
              label: const Text('Salvar ativo'),
            ),
          ],
        ),
      ),
    );
  }
}
