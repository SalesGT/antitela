# Especificação de Requisitos — Projeto AntiTela

---

## 2.1. Funcionalidades

### F01 — Avatar Âncora Gamificado
* **Descrição:** Exibe o mascote virtual do aplicativo cujo estado de humor, postura e energia oscilam em tempo real com base no tempo de uso do smartphone e no cumprimento de metas.
* **Necessidade do usuário que atende:** Substitui a culpa e os bloqueios punitivos por um mecanismo de empatia e responsabilidade visual sobre a própria rotina digital.
* **Justificativa:** É a funcionalidade mais importante do projeto. Funciona como o núcleo de engajamento do aplicativo, transformando a autopercepção em uma jornada lúdica.

### F02 — Sessão de Modo Foco com Silenciamento Nativo (DND)
* **Descrição:** Cronômetro configurável de concentração que se integra à API do sistema operacional para ativar o modo Não Perturbe (DND), silenciando alertas temporariamente.
* **Necessidade do usuário que atende:** Auxilia o jovem a estudar ou realizar tarefas sem a interrupção constante de notificações e tentações digitais.
* **Justificativa:** Reduz ativamente o tempo de tela e a fragmentação da atenção durante períodos acadêmicos ou de descanso.

### F03 — Missões Offline e Sistema de Recompensas
* **Descrição:** Módulo de tarefas do mundo real (estudar, praticar esportes, arrumar o quarto, ler) que concedem escudos e troféus virtuais para proteger a saúde do avatar.
* **Necessidade do usuário que atende:** Incentiva o jovem a buscar alternativas saudáveis fora do smartphone através de reforço positivo.
* **Justificativa:** Estimula a substituição do tempo sedentário de tela por hábitos produtivos no mundo físico.

### F04 — Diário de Humor Pós-Tela
* **Descrição:** Interface de registro rápido (tags de sentimentos e nota de 1 a 5) disparada após longos períodos de uso contínuo ou término do modo foco.
* **Necessidade do usuário que atende:** Promove a reflexão emocional sobre como o consumo prolongado de redes sociais afeta o bem-estar mental.
* **Justificativa:** Identifica gatilhos de ansiedade e compulsão, permitindo que o usuário perceba a relação entre tempo de tela e oscilações de humor.

### F05 — Geração Local de Relatório Familiar (PDF)
* **Descrição:** Compilação automática semanal de métricas consolidadas (tempo total, horários de pico e assiduidade) exportada em formato PDF para apresentação aos pais.
* **Necessidade do usuário que atende:** Permite demonstrar o cumprimento dos acordos familiares sem expor os registros íntimos do diário.
* **Justificativa:** Constrói um canal de transparência e confiança com os responsáveis, reduzindo conflitos domésticos sem violar a privacidade do adolescente.

### F06 — Definição de Metas e Acordos Diários
* **Descrição:** Painel de configuração de limites saudáveis de tempo de tela por período do dia (ex.: teto de uso no período pré-sono).
* **Necessidade do usuário que atende:** Garante autonomia ao jovem para pactuar e gerenciar seus próprios limites em concordância com a família.
* **Justificativa:** Fundamenta a autorregulação voluntária em substituição a regras impostas arbitrariamente por terceiros.

### F07 — Histórico e Gráficos de Evolução de Hábitos
* **Descrição:** Exibição de gráficos comparativos semanais e mensais demonstrando o tempo de tela investido e a evolução do nível do avatar.
* **Necessidade do usuário que atende:** Permite visualizar o progresso contínuo e a melhora nos hábitos ao longo do tempo.
* **Justificativa:** Mantém a motivação de longo prazo por meio da visualização do impacto positivo das mudanças comportamentais.

### F08 — Modo de Emergência e Desistência Consciente
* **Descrição:** Recurso que permite interromper a sessão de foco antes do tempo previsto mediante uma breve confirmação, aplicando apenas uma penalidade lúdica ao avatar.
* **Necessidade do usuário que atende:** Garante que o usuário nunca fique preso em situações de emergência real ou comunicação urgente.
* **Justificativa:** Respeita o princípio de não-bloqueio autoritário do dispositivo, mantendo a sensação de controle e segurança no uso do app.

---

## 2.2. Requisitos Funcionais

* **RF01 — Exibição e Atualização do Avatar:** O sistema deve atualizar dinamicamente a expressão e os estados visuais do Avatar Âncora com base no volume de uso coletado do dispositivo.
* **RF02 — Configuração da Sessão de Foco:** O sistema deve permitir que o usuário defina o tempo de duração da sessão de foco e a inicie em no máximo 3 interações.
* **RF03 — Integração com Modo Não Perturbe:** O sistema deve solicitar permissão nativa para acionar e desativar o modo Não Perturbe do sistema operacional durante o Modo Foco.
* **RF04 — Cadastro e Gestão de Missões:** O sistema deve permitir que o usuário cadastre, visualize e marque como concluídas missões do mundo real.
* **RF05 — Atribuição de Recompensas:** O sistema deve creditar escudos e pontos ao avatar no momento em que uma missão offline for concluída pelo usuário.
* **RF06 — Registro no Diário de Humor:** O sistema deve permitir que o usuário selecione tags emocionais e atribua uma pontuação de humor no diário privado.
* **RF07 — Exportação do Relatório PDF:** O sistema deve gerar um arquivo PDF consolidado com o balanço semanal de tempo de uso para compartilhamento externo.
* **RF08 — Ocultação de Dados Privados:** O sistema deve omitir estritamente qualquer anotação ou tag do Diário de Humor na geração do relatório em PDF.
* **RF09 — Notificação de Alerta Pré-Sono:** O sistema deve emitir um alerta visual amigável quando o usuário atingir a janela do horário de repouso configurado.
* **RF10 — Cancelamento de Foco com Penalidade:** O sistema deve permitir a interrupção prematura da sessão de foco, aplicando a perda proporcional de energia do avatar.
* **RF11 — Consulta de Histórico de Hábitos:** O sistema deve exibir gráficos demonstrando a média diária de uso da tela e o histórico de missões cumpridas.
* **RF12 — Configuração de Limites de Uso:** O sistema deve permitir a definição de tetos de tempo de tela em horas/minutos para os períodos matutino, vespertino e noturno.

---

## 2.3. Requisitos Não Funcionais

* **RNF01 — Usabilidade:** O sistema deve permitir que o usuário inicie uma sessão de foco a partir da tela principal com, no máximo, 3 toques na tela.
* **RNF02 — Segurança e Privacidade (LGPD):** O sistema deve armazenar os registros do Diário de Humor e informações pessoais exclusivamente no armazenamento local do dispositivo, sem realizar chamadas de rede para envio desses dados a servidores externos.
* **RNF03 — Desempenho:** O sistema deve operar com taxa de quadros estável em dispositivos com 2GB de memória RAM, apresentando tempo de resposta inferior a 2 segundos para troca de telas e consumo de bateria inferior a 5% por hora em background.
* **RNF04 — Compatibilidade:** O aplicativo deve ser compatível com dispositivos móveis executando a versão Android 8.0 (API nível 26) ou superior.
* **RNF05 — Armazenamento de Dados:** O sistema deve utilizar banco de dados local SQLite (`sqflite`) para a persistência de missões, histórico de foco e registros de humor.
* **RNF06 — Conectividade:** O sistema deve manter 100% das suas funcionalidades operacionais em modo offline, restringindo atualizações em segundo plano e sincronizações secundárias para quando o dispositivo estiver conectado a uma rede Wi-Fi.
* **RNF07 — Acessibilidade e Interface:** O sistema deve implementar interface visual com suporte nativo a Tema Escuro (Dark Mode) permanente, utilizando contraste adequado para uso em ambientes de baixa iluminação.

---

## 2.4. CRUD (Create, Read, Update, Delete)

### Módulo: Missões Offline
* **C (Create):** O usuário cadastra uma nova missão offline (ex.: "Ler 10 páginas de um livro").
* **R (Read):** O sistema lista as missões pendentes e concluídas no painel.
* **U (Update):** O usuário altera o nome da missão ou a marca como concluída para receber a recompensa.
* **D (Delete):** O usuário exclui uma missão customizada que não deseja mais realizar.

### Módulo: Diário de Humor Pós-Tela
* **C (Create):** O usuário registra um novo estado de humor e seleções de tags após o uso ou foco.
* **R (Read):** O usuário consulta o histórico de registros passados no diário.
* **U (Update):** O usuário edita as tags ou observações de um registro efetuado no próprio dia.
* **D (Delete):** O usuário remove um registro do diário que não deseja manter armazenado.

### Operação Não Aplicável (Avatar Âncora)
* **Sem Operação D (Delete):** O Avatar Âncora é a entidade central e permanente da aplicação. Ele não pode ser excluído pelo usuário, admitindo apenas **Leitura (Read)** de seu estado e **Atualização (Update)** de seus parâmetros visuais e energéticos à medida que o tempo passa ou metas são cumpridas.

---

## 2.5. Priorização de Funcionalidades

| Classificação | Funcionalidades | Justificativa |
| :--- | :--- | :--- |
| **Essenciais** | • F01 — Avatar Âncora Gamificado<br>• F02 — Modo Foco com DND<br>• F04 — Diário de Humor Pós-Tela | Formam o núcleo indispensável do projeto para tratar o problema da autopercepção e redução do tempo de tela. |
| **Importantes** | • F03 — Missões Offline e Recompensas<br>• F05 — Relatório Familiar (PDF)<br>• F06 — Definição de Metas e Acordos | Agregam alto valor à experiência, promovendo a troca por hábitos saudáveis e a pactuação pacífica com os pais. |
| **Secundárias** | • F07 — Histórico e Gráficos de Evolução<br>• F08 — Modo de Emergência e Desistência | Recursos de suporte que refinam a usabilidade de longo prazo, mas podem ser incrementados posteriormente. |
