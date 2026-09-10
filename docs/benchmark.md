# Benchmark — AntiTela

**Projeto:** AntiTela — aplicativo de autorregulação do tempo de tela para adolescentes
**Disciplina:** Programação para Dispositivos Móveis
**Arquivo de destino no repositório:** `docs/benchmark.md`

Foram analisadas 3 soluções existentes que representam as três abordagens dominantes no
mercado de controle de tempo de tela: gamificação/autocontrole voluntário (Forest),
bloqueio rígido para foco (Opal) e controle parental (Google Family Link). A escolha
não é aleatória: o estudo de caso do AntiTela define explicitamente que o produto deve
evitar a "batalha de gato e rato" dos bloqueadores tradicionais e a postura de
"vigilante do celular" do controle parental, por isso, cada um desses três modelos é
comparado diretamente com as decisões de design já tomadas para o AntiTela (Avatar
Âncora, ausência de bloqueio forçado, Diário de Bordo privado).

---

## 1. Forest — Mantenha o Foco

**Principais funcionalidades**
- Cronômetro gamificado: o usuário "planta uma semente" que cresce em árvore enquanto
  fica longe do celular; se sair do app antes do tempo, a árvore murcha.
- *Time Guard*, que bloqueia apps selecionados e acompanha o tempo de tela.
- *Mindful Space*, com paisagens sonoras e exercícios de respiração entre sessões.
- Floresta pessoal com histórico e estatísticas de produtividade.
- Parceria com a ONG *Trees for the Future*: moedas virtuais financiam plantio real.

**Pontos positivos**
- Mecânica de recompensa emocional forte: perder a árvore gera senso real de "custo"
  pela distração é o app mais próximo, entre os três, da lógica de "cuidar de algo
  vivo" que o AntiTela adota com o Avatar Âncora.
- Propósito além do indivíduo (impacto ambiental real) aumenta retenção.

**Pontos negativos**
- A árvore murcha de forma binária e definitiva ao fim da sessão, não existe recuperação gradual nem estados intermediários de humor, o que é mais rígido e menos empático do que a proposta do AntiTela de variação de estados do Avatar.
- O bloqueio de apps (Time Guard) é limitado pelas restrições do próprio iOS.
- É pago (compra única ou assinatura), barreira de entrada para adolescentes.
- Não existe qualquer registro de estado emocional do usuário o app mede apenas tempo, não como o usuário se sentiu durante ou depois do uso.

**Interface/experiência**
- Interface minimalista e afetiva, com forte apelo visual, mas orientada a adultos em
  contexto de produtividade/estudo, não a uma rotina familiar mais ampla (sono,
  emoções, relação com os pais).

**O que pode ser aproveitado/melhorado no AntiTela**
- Aproveitar: a lógica de progressão visual (algo cresce/reage ao comportamento) valida
  a aposta do projeto no Avatar Âncora como mecanismo central de engajamento.
- Melhorar: o AntiTela substitui o "tudo ou nada" da árvore por estados graduais de
  humor do avatar, e conecta a recompensa não só a sessões de foco, mas às Missões
  Offline e ao Diário de Bordo — tratando causa (emoção) e efeito (tempo de tela), não
  apenas o tempo isoladamente.

---

## 2. Opal — Screen Time Control

**Principais funcionalidades**
- Bloqueio de apps/sites em horários programados ao longo da semana.
- *Focus Difficulty*, incluindo um modo "Deep Focus" que **não permite cancelar nem
  contornar o bloqueio** enquanto ativo.
- Limites diários de uso por app/site, com bloqueio automático ao atingir o limite.
- Relatórios de foco com métricas e ranking entre amigos.

**Pontos positivos**
- Resolve, de forma mais eficaz que o Forest, o problema de consequência técnica real:
  o bloqueio realmente impede o uso, não depende só de força de vontade.

**Pontos negativos — este é o contraponto mais direto ao AntiTela**
- O modo "Deep Focus", que impede cancelar o bloqueio a qualquer momento, é exatamente o
  tipo de trava autoritária que o estudo de caso do AntiTela rejeita explicitamente: em
  uma emergência real (contato familiar, emergência de saúde, comunicado da escola), o
  usuário fica impedido de agir, um risco que o AntiTela evita por princípio de design,
  permitindo encerrar o Modo Foco a qualquer momento (com custo apenas na gamificação,
  nunca no acesso ao aparelho).
- Foco quase exclusivo em produtividade adulta/profissional; linguagem e casos de uso
  (trabalho, TDAH corporativo) não dialogam com o cotidiano escolar de um adolescente.
- Não existe qualquer camada voltada a responsáveis/pais é 100% autogerenciamento,
  o que não cobre a necessidade de transparência familiar sem invasão de privacidade que o AntiTela busca atender.
- Modelo de assinatura é obstáculo de acesso para o público jovem.

**Interface/experiência**
- Interface orientada a dados e produtividade corporativa (gráficos, "Focus Score"),
  distante do tom "jovem e descontraído" que o AntiTela definiu como identidade.

**O que pode ser aproveitado/melhorado no AntiTela**
- Aproveitar: a ideia de níveis de rigidez de bloqueio é válida mas reinterpretada par seguir a ideia principal do Antitela.
  O AntiTela pode oferecer níveis de compromisso na sessão de Modo Foco (ex: silenciar
  mais ou menos notificações), sem nunca chegar ao nível "impossível de sair" do Opal.
- Melhorar: o Modo Foco do AntiTela usa Não Perturbe (DND) nativo do sistema, silenciando
  alertas sem travar o aparelho mantendo a autonomia moral do usuário como prioridade
  de design, ao contrário do bloqueio mecânico do Opal.

---

## 3. Google Family Link

**Principais funcionalidades**
- Limites diários de tempo de uso do dispositivo, com horários de aula e descanso.
- Limites individuais de tempo por aplicativo.
- Aprovação/bloqueio remoto de instalação de apps, com filtro por classificação etária.
- Relatórios de atividade semanais/mensais sobre uso de cada app pela criança.
- Localização do dispositivo e bloqueio remoto do aparelho.

**Pontos positivos**
- Solução robusta e gratuita, com grande cobertura de recursos de controle parental.
- Consolida em um único painel dos pais boa parte da visibilidade que as famílias
  buscam algo que o Relatório Semanal em PDF do AntiTela também busca oferecer, de
  forma mais leve.

**Pontos negativos — o contraponto mais importante para a proposta de valor do AntiTela**
- É uma ferramenta de vigilância unilateral: os pais controlam, o filho apenas sofre os
  limites impostos, sem qualquer canal de autopercepção ou protagonismo próprio o
  oposto do papel central que o AntiTela dá ao adolescente como "operador diário" do
  Avatar, das Missões e do Diário de Bordo.
- Não protege a privacidade emocional do jovem: por ser uma ferramenta de monitoramento
  amplo, não há separação entre dados de uso (aceitável de compartilhar) e conteúdo
  íntimo (que deveria ser protegido) distinção que o AntiTela trata como requisito
  crítico ao isolar o Diário de Bordo no dispositivo do jovem, fora do relatório dos pais.
- Tende a gerar resistência e conflito familiar em adolescentes mais velhos, que
  percebem a ferramenta como vigilância, não como apoio, exatamente o problema que o
  estudo de caso do AntiTela aponta como falha estrutural do controle parental
  tradicional.

**Interface/experiência**
- Interface administrativa voltada ao app do responsável; do lado do adolescente, a
  experiência é passiva, sem elementos de engajamento ou recompensa.

**O que pode ser aproveitado/melhorado no AntiTela**
- Aproveitar: a separação entre "painel dos pais" e "dispositivo do filho", e os limites
  por horário/contexto (aula, sono), são um modelo já validado e aceito socialmente,
  alinhado à Lei nº 15.100/2025 sobre celulares em escolas.
- Melhorar: o AntiTela reduz drasticamente o atrito familiar do Family Link ao entregar
  aos pais apenas um relatório consolidado (dados objetivos de tempo/assiduidade),
  nunca o conteúdo do Diário de Bordo trocando vigilância por transparência pactuada.

---

## 4. O que o AntiTela poderá fazer de diferente ou melhor?

Nenhuma das três soluções analisadas resolve, ao mesmo tempo, os três problemas centrais
identificados na pesquisa: **falta de consequência real** (fraqueza do Forest),
**rigidez autoritária que ignora emergências e gera resistência** (fraqueza do Opal) e
**vigilância que anula a privacidade e o protagonismo do adolescente** (fraqueza do
Family Link).

O AntiTela se diferencia ao:

1. **Substituir bloqueio autoritário por consequência gamificada e reversível** — o
   Avatar Âncora reage ao comportamento do usuário, mas a saída do Modo Foco nunca é
   tecnicamente impedida, preservando a autonomia moral do adolescente mesmo em
   situações de urgência (diferente do "Deep Focus" do Opal).
2. **Separar dado objetivo de conteúdo íntimo** — o Relatório Semanal em PDF entregue
   aos pais mostra tempo de uso e assiduidade às metas, mas nunca o conteúdo do Diário
   de Bordo, resolvendo o principal ponto de atrito do Family Link (vigilância que
   invade a privacidade emocional do jovem).
3. **Recompensar a causa, não só o efeito** — em vez de medir apenas tempo de tela
   (como Forest e Opal), o AntiTela conecta o estado do Avatar às Missões Offline e ao
   Diário de Bordo, tratando também a raiz emocional do uso compulsivo (ansiedade,
   FOMO, nomofobia) identificada na pesquisa, não apenas o sintoma numérico.
4. **Adotar tom de "aliado", não de fiscal** — a identidade de marca do AntiTela (jovem, descontraída, sem infantilizar) evita tanto o tom corporativo do Opal quanto o tom de vigilância do Family Link, respondendo diretamente ao achado da pesquisa de que regras impostas sem adesão voluntária têm efeito limitado sobre o comportamento real.
