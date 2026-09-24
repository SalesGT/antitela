# Especificação de Requisitos — Projeto AntiTela

---

## 2.1. Funcionalidades

### 1. Avatar Âncora Gamificado
* **Descrição:** Mascote virtual que reflete a saúde digital do usuário em tempo real, alterando estados visuais (saudável, cansado, esgotado) com base nas horas de tela e no cumprimento de metas.
* **Necessidade do usuário:** Substitui o sentimento de punição externa por empatia e responsabilidade direta pelo mascote.
* **Justificativa:** É a peça central da gamificação do AntiTela, engajando o adolescente sem a necessidade de bloqueios mecânicos rígidos.

### 2. Modo Foco com Silenciamento Nativo (DND)
* **Descrição:** Temporizador configurável de concentração que ativa o modo *Não Perturbe* do sistema operacional para bloquear notificações de redes sociais durante o estudo.
* **Necessidade do usuário:** Reduz a fricção e as interrupções frequentes provocadas por alertas durante tarefas escolares.
* **Justificativa:** Permite que o jovem treine ciclos de foco produtivo com facilidade de acionamento.

### 3. Quadro de Missões e Hábitos Offline
* **Descrição:** Módulo de tarefas do mundo real (estudar, praticar esportes, arrumar o quarto) que concedem pontos, troféus e escudos de proteção para o avatar.
* **Necessidade do usuário:** Estimula a desconexão e incentiva a realização de atividades físicas e acadêmicas fora das telas.
* **Justificativa:** Valoriza o tempo desconectado como fonte de recompensa dentro do aplicativo.

### 4. Diário de Bordo (Registro de Humor Pós-Tela)
* **Descrição:** Interface de checagem emocional rápida (tags e emojis) exibida após longas sessões de uso ou ao final do dia.
* **Necessidade do usuário:** Desenvolve a autopercepção sobre como o consumo prolongado de redes impacta o humor e a ansiedade.
* **Justificativa:** Promove a autorregulação do jovem através do registro reflexivo de sentimentos.

### 5. Gerador de Relatório Semanal em PDF Local
* **Descrição:** Módulo que sintetiza as métricas de tempo de uso global, assiduidade no modo foco e hábitos cumpridos em um documento PDF exportável.
* **Necessidade do usuário:** Fornece aos pais uma visão consolidada do progresso do filho sem invadir sua intimidade.
* **Justificativa:** Garante a transparência nas pactuações familiares mantendo a privacidade do adolescente.

### 6. Painel de Estatísticas e Tempo de Uso
* **Descrição:** Visualizador de gráficos interativos com a contagem diária e semanal de tempo de tela e categorias de aplicativos mais consumidos.
* **Necessidade do usuário:** Oferece dados concretos para que o jovem compreenda onde seu tempo está sendo gasto.
* **Justificativa:** É a base quantitativa necessária para a tomada de decisão voluntária de mudança de hábito.

### 7. Sistema de Recompensas (Escudos e Troféus)
* **Descrição:** Inventário virtual onde o usuário armazena escudos acumulados para proteger a vida do avatar em dias inevitáveis de uso prolongado.
* **Necessidade do usuário:** Evita a frustração e o abandono do app quando o tempo de tela alto for inevitável (ex.: trabalhos escolares).
* **Justificativa:** Mantém a mecânica justa e tolerante a falhas do cotidiano do usuário.

### 8. Protótipo Interativo / Simulador de Regras (React/JSX)
* **Descrição:** Ambiente de demonstração das regras de negócio, transições do avatar e simulação de fluxos sem necessidade de compilação em dispositivos móveis.
* **Necessidade do usuário:** Validação ágil de usabilidade e testes do comportamento do avatar.
* **Justificativa:** Permite apresentar e validar as regras da aplicação em qualquer plataforma de forma leve.

---

## 2.2. Requisitos Funcionais (RF)

* **RF01 — Exibição de Estado do Avatar:** O sistema deve atualizar e exibir o estado visual e o nível de energia do Avatar Âncora com base no tempo de tela e nas missões concluídas.
* **RF02 — Acionamento do Modo Foco:** O sistema deve permitir iniciar uma sessão de temporizador de foco em no máximo 3 toques a partir da tela inicial.
* **RF03 — Integração com Modo Não Perturbe:** O sistema deve solicitar permissão e acionar o recurso nativo de silenciamento de notificações ao iniciar o Modo Foco.
* **RF04 — Cadastro de Missões:** O sistema deve permitir que o usuário cadastre, personalize e visualize tarefas e hábitos offline.
* **RF05 — Conclusão de Missões:** O sistema deve permitir registrar a conclusão de missões e creditar automaticamente escudos ou pontos na conta do usuário.
* **RF06 — Registro no Diário de Humor:** O sistema deve permitir ao usuário registrar seu estado emocional e associar tags rápidas de humor.
* **RF07 — Consulta ao Diário de Bordo:** O sistema deve permitir a leitura exclusiva do histórico de registros emocionais gravados pelo próprio jovem.
* **RF08 — Exportação de PDF:** O sistema deve gerar e exportar um relatório semanal consolidado com dados de tempo de uso e cumprimento de metas.
* **RF09 — Leitura de Tempo de Tela:** O sistema deve coletar o tempo total de uso de aplicativos por meio do subsistema nativo do dispositivo (`UsageStatsManager`).
* **RF10 — Aplicação de Escudos:** O sistema deve permitir o uso de escudos salvos para neutralizar a perda de vida do avatar em dias de uso elevado.
* **RF11 — Simulação de Regras:** O sistema deve permitir a alteração manual de parâmetros no protótipo interativo para testar estados do avatar.
* **RF12 — Exclusão de Dados Locais:** O sistema deve permitir que o usuário apague todo o histórico do diário de humor e dados salvos no dispositivo.

---

## 2.3. Requisitos Não Funcionais (RNF)

* **RNF01 — Usabilidade:** O usuário deve conseguir acessar a funcionalidade principal (Modo Foco) em, no máximo, três interações a partir do acesso ao app.
* **RNF02 — Desempenho e Consumo:** O aplicativo deve rodar de forma estável em dispositivos Android com 2GB de memória RAM, mantendo o consumo de CPU em segundo plano abaixo de 5%.
* **RNF03 — Segurança e Privacidade (LGPD):** O sistema deve armazenar os registros do Diário de Humor estritamente no banco de dados local (`SQLite`), sem envio de dados pessoais sensíveis para servidores externos.
* **RNF04 — Conectividade (Offline-First):** O aplicativo deve manter pleno funcionamento de suas funções principais em modo offline, restringindo a sincronização de estatísticas pesadas estritamente a conexões Wi-Fi.
* **RNF05 — Compatibilidade:** O sistema deve ser compatível com dispositivos executando o sistema operacional Android 8.0 (API nível 26) ou superior.
* **RNF06 — Acessibilidade e Interface:** O aplicativo deve oferecer interface nativa em modo escuro (Dark Mode) com taxa de contraste mínima de 4.5:1 para visualização confortável em ambientes de pouca luz.

---

## 2.4. Mapeamento CRUD

| Entidade / Informação | Criar (C) | Consultar (R) | Atualizar (U) | Excluir (D) | Justificativa de Exceções |
| :--- | :---: | :---: | :---: | :---: | :--- |
| **Missões Offline** | Sim | Sim | Sim | Sim | Operação CRUD completa para personalização da rotina do usuário. |
| **Diário de Bordo (Humor)** | Sim | Sim | Não | Sim | **Atualização não permitida:** Garante a fidedignidade histórica dos sentimentos registrados no momento da reflexão. |
| **Sessões de Foco** | Sim | Sim | Não | Sim | Históricos de foco são imutáveis após finalizados; o usuário só pode apagar o registro. |
| **Configurações do Avatar** | Sim | Sim | Sim | Não | **Exclusão não permitida:** O avatar é a entidade fixa da aplicação; só permite alteração de estado e personalização. |

---

## 2.5. Priorização das Funcionalidades

| Funcionalidade | Classificação | Justificativa Técnica / Regra de Negócio |
| :--- | :--- | :--- |
| **Avatar Âncora Gamificado** | **Essencial** | Elemento central de motivação e retenção do usuário. |
| **Modo Foco com Silenciamento Nativo** | **Essencial** | Ferramenta principal para viabilizar a concentração prática. |
| **Diário de Bordo (Humor)** | **Essencial** | Cumpre o requisito pedagógico de autopercepção e saúde mental. |
| **Leitura de Tempo de Tela** | **Essencial** | Fornece os dados de entrada para atualizar a saúde do avatar. |
| **Quadro de Missões Offline** | **Importante** | Agrega valor incentivando hábitos fora do ambiente digital. |
| **Gerador de Relatório PDF** | **Importante** | Viabiliza a transparência e comunicação entre pais e filhos. |
| **Sistema de Recompensas (Escudos)** | **Importante** | Evita o abandono do app em dias de uso inevitável das telas. |
| **Protótipo Interativo React/JSX** | **Secundária** | Utilitário de demonstração e testes de regras de negócio em sala. |

---

## Funcionalidade Mais Importante para a Apresentação

* **Funcionalidade Elegida:** **Avatar Âncora Gamificado**
* **Justificativa:** É a inovação que diferencia o AntiTela dos bloqueadores parentais tradicionais. Em vez de impor travas autoritárias que geram revolta e burla por parte do adolescente, ela converte a gestão do tempo em responsabilidade e empatia virtual. Ao visualizar o impacto direto do seu comportamento na saúde do mascote, o jovem passa a autorregular seu tempo por escolha própria, atendendo ao objetivo central do projeto.
