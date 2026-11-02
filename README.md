📈 Carteira App

App em Flutter para acompanhar e analisar uma carteira de investimentos.

Este é um projeto de estudos: a ideia é aprender Flutter na prática, construindo um app real em fases, onde cada etapa introduz conceitos novos (widgets, navegação, persistência, gerenciamento de estado, consumo de APIs e visualização de dados).

🎯 Objetivo

Construir um app que permita cadastrar os ativos da carteira (ações, FIIs, renda fixa e cripto), acompanhar o valor investido, consultar cotações atualizadas e visualizar a distribuição e a rentabilidade da carteira.

🗺️ Roadmap
✅ Fase 1: Estrutura e telas básicas
 Tela principal com resumo do total investido
 Lista de ativos com valor investido por posição
 Formulário de cadastro com validação
 Remoção de ativos com opção de desfazer
 Organização do código em models, screens, widgets e utils

Conceitos estudados: StatelessWidget vs StatefulWidget, setState, ListView.builder, Form e validação, TextEditingController, navegação com retorno de dados (Navigator.push/pop), Dismissible e SnackBar.

Exercícios de fixação:

 Tela de detalhes ao tocar em um ativo
 Edição de um ativo reaproveitando o formulário
 Impedir cadastro de ticker duplicado
⏳ Fase 2: Persistência local
 Salvar os ativos no dispositivo (dados não se perdem ao fechar o app)
 Serialização com toJson / fromJson
 Trocar "ativo" por "transação" (compra/venda com data) e calcular o preço médio automaticamente
 Formatação de moeda com o pacote intl
⏳ Fase 3: Gerenciamento de estado
 Adotar um gerenciador de estado (Provider ou Riverpod)
 Compartilhar os dados da carteira entre várias telas
⏳ Fase 4: Cotações em tempo real
 Consumir API de cotações da B3 (ex: brapi.dev)
 Tratamento de carregamento e erros (async/await, FutureBuilder)
 Rentabilidade por ativo e da carteira
 Chaves de API fora do repositório
⏳ Fase 5: Análise e visualização
 Gráfico de distribuição por tipo de ativo (fl_chart)
 Evolução patrimonial ao longo do tempo
 Comparação com benchmarks (CDI, Ibovespa)
 Metas de alocação e sugestão de rebalanceamento
🧪 Contínuo
 Testes unitários para os cálculos financeiros (preço médio, rentabilidade)
🛠️ Tecnologias
Flutter / Dart
Material 3
VS Code com as extensões Flutter e Dart
Android Emulator
📂 Estrutura do projeto
lib/
├── main.dart                      # Ponto de entrada e tema do app
├── models/
│   └── ativo.dart                 # Modelo de dados e tipos de ativo
├── screens/
│   ├── lista_ativos_screen.dart   # Tela principal com resumo e lista
│   └── adicionar_ativo_screen.dart# Formulário de cadastro
├── widgets/
│   └── ativo_card.dart            # Card de exibição de um ativo
└── utils/
    └── formatadores.dart          # Formatação de moeda e quantidade
▶️ Como executar

Pré-requisitos: Flutter SDK instalado e um emulador Android, dispositivo físico ou navegador Chrome.

bash
git clone https://github.com/GustavoSilvaTesting/carteira_app.git
cd carteira_app
flutter pub get
flutter run

Para verificar se o ambiente está configurado corretamente, rode flutter doctor.

📝 Aprendizados

Anotações de problemas encontrados e como foram resolvidos ao longo do projeto:

NDK não encontrado no primeiro build Android: o Gradle não conseguiu instalar automaticamente a versão do NDK exigida pelo projeto. Resolvido instalando a versão específica pelo SDK Manager do Android Studio (aba SDK Tools, com "Show Package Details" marcado).
Hot reload vs hot restart: o hot reload aplica mudanças mantendo o estado do app; quando a estrutura muda muito (como trocar a tela inicial), é preciso usar o hot restart.
👤 Autor

Gustavo Silva · GitHub