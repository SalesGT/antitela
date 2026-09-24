# Justificativas de UI/UX e Arquitetura - AntiTela

Este documento regista as principais decisões de interface e arquitetura tomadas durante a transição do protótipo de baixa fidelidade para a solução final de alta fidelidade.

## 1. Decisões Visuais e de Interface
* **Escolha das Cores (Paleta e Contraste):** A paleta foi desenhada para reduzir o cansaço visual, adequando-se ao uso noturno (prevenção de insónias). Utilizam-se cores de alerta (verde, amarelo, vermelho) de forma minimalista para indicar o estado da "bateria mental" do avatar e o tempo de ecrã[cite: 15].
* **Tipografia (Hierarquia e Legibilidade):** Optou-se por fontes sem serifa (sans-serif) com pesos variados para criar uma hierarquia clara. Os temporizadores no "Modo Foco" utilizam fontes monoespaçadas (ou dimensões fixas) para evitar saltos visuais durante a contagem do relógio[cite: 12].
* **Ícones e Componentes:** Os componentes adotam cantos arredondados (cards) para uma estética mais amigável. Foram criados botões de área de toque ampla, especialmente para a seleção dos tempos de foco (25, 45 ou 60 minutos)[cite: 12].

## 2. Organização e Navegação
* **Organização das Informações:** O ecrã inicial foca-se no imediato: o estado do utilizador (Avatar) e o tempo de ecrã atual[cite: 15]. Tarefas e missões offline foram separadas em listas expansíveis para não sobrecarregar cognitivamente o utilizador[cite: 13].
* **Navegação:** Implementou-se uma barra de navegação inferior (Bottom Navigation Bar) rasa e direta, dividida em quatro secções principais: `[Avatar]`, `[Metas]`, `[Foco]` e `[Diário]`[cite: 12, 13, 14, 15]. Isto permite o acesso a qualquer funcionalidade primária com apenas um toque.

## 3. Acessibilidade e Contexto de Uso
* **Acessibilidade:** O contraste entre o texto e o fundo cumpre as normas WCAG (ideal para utilizadores com vista cansada ao fim do dia). As áreas de clique (touch targets) dos botões de nova missão[cite: 13] e registo de humor[cite: 14] foram desenhadas com um mínimo de 48x48dp.
* **Contexto de Uso:** Sendo uma aplicação para redução de danos digitais, o design incentiva interações curtas. A secção de Diário foi projetada para transmitir segurança através do cadeado visual, reforçando que os dados de saúde mental e o histórico de ansiedade são "100% privados"[cite: 14].

## 4. Arquitetura do Sistema
* **Visão Geral:** A aplicação adota uma arquitetura *Offline-First* e de processamento local, fundamental para garantir a privacidade prometida no Diário[cite: 14] e suportar o modo de "Missões Offline"[cite: 13]. 
* **Componentes Principais:**
  * **Frontend:** Construído de forma reativa, refletindo instantaneamente as alterações de estado (ex: ganhar um troféu ou alterar a saúde do avatar)[cite: 13, 15].
  * **Armazenamento:** Bases de dados locais (como SQLite/SharedPreferences) para guardar o histórico do Diário, estado das Metas e configurações sem necessidade de envio para a nuvem.
