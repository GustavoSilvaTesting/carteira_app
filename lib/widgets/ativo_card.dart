import 'package:flutter/material.dart';

import '../models/ativo.dart';
import '../utils/formatadores.dart';

/// Card que exibe um ativo na lista.
/// É Stateless porque só mostra dados que recebe de fora.
class AtivoCard extends StatelessWidget {
  final Ativo ativo;

  const AtivoCard({super.key, required this.ativo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(child: Text(ativo.tipo.label[0])),
        title: Text(
          ativo.ticker,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${formatarQuantidade(ativo.quantidade)} × '
          '${formatarReais(ativo.precoMedio)} (${ativo.tipo.label})',
        ),
        trailing: Text(
          formatarReais(ativo.valorInvestido),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
