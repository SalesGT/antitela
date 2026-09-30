AntiTela — Regulação Saudável do Tempo de Tela para Adolescentes
Projeto acadêmico focado em promover a saúde digital, a higiene do sono e a autorregulação juvenil através de gamificação e empatia virtual, sem vigilância invasiva.
📌 Informações Gerais
 * Nome do Projeto: AntiTela
 * Turma: PROGRAMAÇÃO PARA DISPOSITIVOS MÓVEIS - GP0015NOT07A
 * Repositório: SalesGT/antitela
 * Integrantes do Grupo:
   * João Gabriel da Costa Souza
   * Luka Goes Ribeiro
   * Nycolas Davi Gomes Ribeiro
   * Samy Rocha Guilherme dos Santos
   * Tiago Sales Guimarães
📝 Breve Descrição do Projeto
O AntiTela é um aplicativo mobile desenvolvido em Flutter que substitui modelos punitivos de controle parental por uma abordagem de autocuidado gamificada. Centrado na figura de um Avatar Âncora que adoece com o excesso de uso do smartphone e se recupera com atividades no mundo real, o app oferece um cronômetro de foco com silenciamento nativo de notificações (Não Perturbe do Android), missões offline e um diário de humor pós-tela estritamente privado. A prestação de contas com os responsáveis ocorre de forma transparente por meio de relatórios consolidados em PDF exportados periodicamente, fortalecendo a confiança familiar.
📁 Estrutura do Repositório
.
├── README.md                          <- Identificação da equipe, escopo e navegação geral
├── CHANGELOG.md                       <- Histórico de versões e alterações do repositório
└── docs/
    ├── estudo-de-caso.md              <- Atividade 01: Análise crítica do estudo de caso
    ├── pesquisa.md                    <- Atividade 02: Pesquisa bibliográfica sobre nomofobia e sono
    ├── benchmark.md                   <- Atividade 02: Análise comparativa de concorrentes (Forest, Opal, etc.)
    ├── personas.md                    <- Atividade 02: Personas (Lucas - Prioritária, Júlia - Secundária)
    ├── requisitos.md                  <- Atividade 03: Engenharia de Requisitos (RFs, RNFs, Matriz CRUD)
    ├── apresentacaoRequisitos.pdf     <- Atividade 03: Slides de apresentação da Engenharia de Requisitos
    ├── prototipoBaixaFidelidade.pdf   <- Atividade 04: Wireframes estruturais das 4 telas principais
    ├── prototipoAltaFidelidade.pdf    <- Atividade 04: Exportação em PDF do protótipo de alta fidelidade
    ├── LinkPrototipoAltaFidelidade    <- Atividade 04: Atalho para o protótipo navegável no Figma
    ├── justificativas.md              <- Atividade 04: Decisões de UI/UX, cores, acessibilidade e arquitetura
    └── apresentacaoFinalUnidadeI.pdf  <- Atividade 05: Apresentação consolidada de encerramento da Unidade I

👥 Distribuição de Responsabilidades por Atividade
| Integrante | Atividade 01 (Estudo de Caso) | Atividade 02 (Pesquisa & Personas) | Atividade 03 (Requisitos & CRUD) | Atividade 04 (Prototipação & UI/UX) | Atividade 05 (Apresentação Final Unidade I) |
|---|---|---|---|---|---|
| Nycolas Davi Gomes Ribeiro | Coordenação geral e formulação crítica do Problema (2.1) | Pesquisa bibliográfica e fontes sobre saúde digital (pesquisa.md) | Mapeamento de Requisitos Funcionais (RF01 a RF06) | Validação do fluxo de navegação do protótipo em baixa fidelidade | Apresentação do Problema e Visão Geral no Slide 02 |
| Tiago Sales Guimarães | Mapeamento dos Públicos e Usuários (2.2) | Construção do Benchmark comparativo (benchmark.md) | Mapeamento de Requisitos Não Funcionais (RNF01 a RNF06) | Organização da documentação no repositório e CHANGELOG | Apresentação das Personas e Público-Alvo no Slide 04 |
| Luka Goes Ribeiro | Contextos de Uso (2.3) e Restrições Técnicas/Privacidade (2.7) | Elaboração das Personas Lucas e Júlia (personas.md) | Mapeamento da Matriz CRUD das funcionalidades | Definição dos estados dos componentes e interações | Apresentação da Arquitetura do Sistema no Slide 10 |
| João Gabriel da Costa Souza | Mapeamento das Funcionalidades Estabelecidas (2.6) | Síntese de Descobertas e Justificativa da Persona Prioritária | Mapeamento e especificação dos fluxos de dados e requisitos de persistência | Testes de usabilidade e consistência entre protótipos | Apresentação de Requisitos e Mapeamento CRUD no Slide 05 |
| Samy Rocha Guilherme dos Santos | Personalidade, Identidade (2.5) e Pontos de Atenção (2.8) | Consolidação dos slides de apresentação da Atividade 02 | Redação formal do documento requisitos.md e apresentação | Liderança de UI/UX, Design System no Figma e justificativas.md | Liderança de Identidade, UI/UX e Apresentação do Fluxo nos Slides 07, 08 e 09 |
🎨 UI/UX e Prototipação (Atividade 04)
A interface do AntiTela foi desenhada seguindo princípios de Design Humanizado, Acessibilidade e Prevenção do Cansaço Visual.
 * Protótipo de Baixa Fidelidade: Focado na estrutura das 4 telas centrais (Home/Avatar, Modo Foco, Missões Offline e Diário de Humor), garantindo que a navegação seja fluida e o foco seja ativado em no máximo 3 toques. Documentado em docs/prototipoBaixaFidelidade.pdf.
 * Protótipo de Alta Fidelidade (Figma): Apresenta a identidade visual completa em tema noturno (fundo azul-escuro, acentos em roxo e verde), componentes responsivos, acessibilidade WCAG (contraste de 19.3:1 no texto principal) e estados interativos.
   * 🔗 Aceder ao Protótipo Interativo no Figma
   * 📄 Documentado em PDF em docs/prototipoAltaFidelidade.pdf.
 * Justificativas Técnicas e de Design: Análise detalhada das escolhas de paleta de cores, tipografia, contraste, acessibilidade e arquitetura offline-first documentada em docs/justificativas.md.
📚 Documentação da Unidade I
Todos os entregáveis exigidos ao longo da Unidade I encontram-se disponíveis na pasta docs/:
 * Estudo de Caso — Análise inicial de requisitos e contexto.
 * Pesquisa de Mercado — Fundamentação teórica sobre uso de ecrãs e higiene do sono.
 * Benchmark — Análise comparativa de concorrentes.
 * Personas — Definição dos perfis de utilizador primário e secundário.
 * Engenharia de Requisitos — Especificação técnica de RFs, RNFs e CRUD.
 * Justificativas de UI/UX — Decisões de design, acessibilidade e arquitetura.
 * Apresentação Final da Unidade I — Slides consolidados da defesa do projeto.
🚀 Como Executar o Protótipo Interativo
Para testar a experiência visual e a navegação do projeto:
 * Acesse o link público do Figma do AntiTela.
 * Utilize o menu inferior de navegação para alternar entre os ecrãs de Avatar, Modo Foco, Missões Offline e Diário.
 * Na aba de Modo Foco, selecione um tempo pré-definido (25, 45 ou 60 minutos) e clique em "Iniciar Modo Foco" para simular o acionamento do temporizador em até 3 toques.
