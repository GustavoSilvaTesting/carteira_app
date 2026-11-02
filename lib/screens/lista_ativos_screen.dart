import 'package:flutter/material.dart';

import '../models/ativo.dart';
import '../utils/formatadores.dart';
import '../widgets/ativo_card.dart';
import 'adicionar_ativo_screen.dart';

/// Tela principal: mostra o resumo e a lista de ativos.
/// É Stateful porque a lista muda (adicionar/remover).
class ListaAtivosScreen extends StatefulWidget {
  const ListaAtivosScreen({super.key});

  @override
  State<ListaAtivosScreen> createState() => _ListaAtivosScreenState();
}

class _ListaAtivosScreenState extends State<ListaAtivosScreen> {
  // Dados de exemplo, só em memória. Somem ao fechar o app (Fase 2 resolve).
  final List<Ativo> _ativos = [
    const Ativo(
      ticker: 'PETR4',
      quantidade: 100,
      precoMedio: 32.50,
      tipo: TipoAtivo.acao,
    ),
    const Ativo(
      ticker: 'MXRF11',
      quantidade: 200,
      precoMedio: 10.20,
      tipo: TipoAtivo.fii,
    ),
  ];

  double get _totalInvestido =>
      _ativos.fold(0, (soma, ativo) => soma + ativo.valorInvestido);

  /// Abre o formulário e espera ele devolver um Ativo (ou null se cancelar).
  Future<void> _abrirFormulario() async {
    final novoAtivo = await Navigator.push<Ativo>(
      context,
      MaterialPageRoute(builder: (_) => const AdicionarAtivoScreen()),
    );

    if (novoAtivo != null) {
      setState(() => _ativos.add(novoAtivo));
    }
  }

  void _removerAtivo(int index) {
    final removido = _ativos[index];
    setState(() => _ativos.removeAt(index));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removido.ticker} removido'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () => setState(() => _ativos.insert(index, removido)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minha Carteira')),
      body: Column(
        children: [
          _ResumoCarteira(
            total: _totalInvestido,
            quantidadeAtivos: _ativos.length,
          ),
          Expanded(
            child: _ativos.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum ativo cadastrado.\nToque em + para adicionar.',
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    itemCount: _ativos.length,
                    itemBuilder: (context, index) {
                      final ativo = _ativos[index];
                      return Dismissible(
                        key: ObjectKey(ativo),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red.shade400,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 24),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) => _removerAtivo(index),
                        child: AtivoCard(ativo: ativo),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirFormulario,
        tooltip: 'Adicionar ativo',
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Widget privado (o "_" no nome) usado só nesta tela.
class _ResumoCarteira extends StatelessWidget {
  final double total;
  final int quantidadeAtivos;

  const _ResumoCarteira({required this.total, required this.quantidadeAtivos});

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cores.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total investido',
            style: TextStyle(color: cores.onPrimaryContainer),
          ),
          const SizedBox(height: 4),
          Text(
            formatarReais(total),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: cores.onPrimaryContainer,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            quantidadeAtivos == 1 ? '1 ativo' : '$quantidadeAtivos ativos',
            style: TextStyle(color: cores.onPrimaryContainer),
          ),
        ],
      ),
    );
  }
}
