/// Tipos de ativo que a carteira aceita.
/// Cada valor do enum carrega um texto amigável para mostrar na tela.
enum TipoAtivo {
  acao('Ação'),
  fii('FII'),
  rendaFixa('Renda Fixa'),
  cripto('Cripto');

  const TipoAtivo(this.label);
  final String label;
}

/// Representa uma posição da carteira.
class Ativo {
  final String ticker;
  final double quantidade;
  final double precoMedio;
  final TipoAtivo tipo;

  const Ativo({
    required this.ticker,
    required this.quantidade,
    required this.precoMedio,
    required this.tipo,
  });

  /// Getter calculado: não é guardado, é computado sempre que lido.
  double get valorInvestido => quantidade * precoMedio;
}
