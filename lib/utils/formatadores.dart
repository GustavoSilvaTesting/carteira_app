/// Formata um valor como moeda brasileira simples (ex: R$ 1250,50).
/// Na Fase 2 você pode trocar isso pelo pacote `intl`,
/// que também coloca o separador de milhar.
String formatarReais(double valor) {
  return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
}

/// Mostra "100" em vez de "100.0" quando a quantidade é inteira.
String formatarQuantidade(double quantidade) {
  if (quantidade == quantidade.roundToDouble()) {
    return quantidade.toInt().toString();
  }
  return quantidade.toString().replaceAll('.', ',');
}
