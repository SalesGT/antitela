# Personas — AntiTela

**Projeto:** AntiTela — aplicativo de autorregulação do tempo de tela para adolescentes
**Disciplina:** Programação para Dispositivos Móveis
**Arquivo de destino no repositório:** `docs/personas.md`

As personas abaixo detalham, em nível individual, os dois públicos já definidos na
Análise Crítica do Estudo de Caso (seção 2.2): o adolescente (usuário primário) e o
responsável/educador (usuário secundário). Foram construídas a partir dos dados de
`docs/pesquisa.md` em especial os achados sobre falta de supervisão parental, uso
noturno associado à supressão de melatonina, e nomofobia/FOMO como necessidade
emocional real, não apenas hábito.

---

## Persona 1 — Lucas Andrade (adolescente, usuário primário)

**Nome fictício:** Lucas Andrade
**Idade:** 15 anos

**Perfil/contexto**
Lucas está no 9º ano do ensino fundamental, mora com os pais e tem smartphone próprio
desde os 11 anos. É nativo digital, imerso em redes sociais, jogos online e
mensageiros instantâneos com o grupo de amigos. Passa em média 6 a 8 horas por dia em
telas bem acima do limite de 2 a 3 horas recomendado pela SBP para sua faixa etária
e frequentemente rola o feed já deitado, no escuro, até tarde da noite, mesmo
percebendo que dorme mal e acorda cansado. É sensível a qualquer sinal de perda de
autonomia e já aprendeu a contornar bloqueadores e regras impostas pelos pais.

**Objetivos**
- Ter mais controle sobre o próprio tempo de tela sem se sentir vigiado ou tratado
  como criança.
- Dormir melhor e render mais nos estudos.
- Continuar conectado com os amigos sem perder horas "sem perceber" nas redes.

**Necessidades**
- Autonomia real na tomada de decisão — nunca ser trancado à força fora de um app.
- Garantia estrita de que seus registros de humor e desabafos no Diário de Bordo são
  privados e nunca chegam ao relatório dos pais.
- Feedback lúdico e gratificante imediato (o Avatar Âncora reagindo às suas escolhas).
- Ausência de humilhação, punição ou vigilância opressiva.

**Dores**
- Perde a noção do tempo ao entrar em redes sociais ("entrei para ver uma coisa e
  fiquei uma hora").
- Sente ansiedade de ficar "por fora" do que os amigos comentam (FOMO) e desconforto
  quando fica sem o celular por perto (nomofobia).
- Sofre com queda no desempenho escolar, sono ruim e atritos em casa por causa do
  celular.

**Comportamentos**
- Verifica o celular dezenas de vezes ao dia, inclusive em sala de aula.
- Usa o celular deitado, no escuro, como última coisa antes de dormir.
- Reage mal a controles impostos verbalmente pelos pais, mas se engaja bem com
  desafios, recompensas visuais e um personagem/avatar que "depende" dele.
- Precisa, ocasionalmente, encerrar qualquer sessão de foco sem aviso prévio para
  atender ligação de emergência da família ou da escola.

**Relação com o aplicativo**
Lucas é o operador diário do AntiTela: interage com o Avatar Âncora, cumpre Missões
Offline para ganhar escudos e troféus, ativa o Modo Foco (silenciamento de
notificações via DND, nunca bloqueio forçado) durante o estudo ou antes de dormir, e
registra rapidamente (via tags de 5 segundos) como se sentiu após uma sessão de tela
no Diário de Bordo sabendo que esse conteúdo nunca sai do próprio aparelho.

---

## Persona 2 — Renata Souza (mãe/responsável, usuária secundária)

**Nome fictício:** Julia Souza
**Idade:** 42 anos

**Perfil/contexto**
Julia é mãe de Lucas, trabalha em período integral e se preocupa com o tempo que o
filho passa no celular, especialmente à noite. Já tentou impor regras verbais
("larga o celular"), o que gera conflito e é ignorado. Concorda com a lógica por trás
da Lei nº 15.100/2025 (restrição de celular em escolas) e gostaria de estender um
princípio parecido para casa, mas sem se tornar uma "vigilante do celular" o tempo
todo, não quer, e sabe que não deveria, ler as conversas ou os pensamentos íntimos do
filho.

**Objetivos**
- Ajudar o filho a ter uma relação mais saudável com o celular, sem virar fonte
  constante de conflito em casa.
- Ter visibilidade confiável sobre o tempo de uso e a adesão às metas combinadas, sem
  precisar checar o aparelho do filho manualmente.
- Sentir que está cumprindo seu papel de responsável, sem invadir o espaço de
  desenvolvimento e privacidade do filho.

**Necessidades**
- Um relatório periódico, simples e consolidado (o Relatório Semanal em PDF), sem
  necessidade de conhecimento técnico para interpretá-lo.
- Garantia explícita de que dados privados (Diário de Bordo) do filho não estão
  incluídos nesse relatório, condição inegociável para que confie na ferramenta.
- Um instrumento neutro para pactuar limites (horário de aula, hora de dormir) em
  conjunto com o filho, em vez de impor regras sozinha.

**Dores**
- Sente que está "brigando" com o filho por causa do celular, o que desgasta a
  relação familiar.
- Não sabe distinguir com segurança entre uso "normal" para a idade e um padrão que
  já preocupa (privação de sono, ansiedade).
- Falta de tempo para acompanhar de perto o uso digital do filho no dia a dia.

**Comportamentos**
- Prefere soluções automáticas e consolidadas a precisar configurar ou checar algo
  manualmente todos os dias.
- Confia mais em recomendações baseadas em fontes reconhecidas (ex: diretrizes da
  Sociedade Brasileira de Pediatria) do que em regras arbitrárias próprias.
- Está disposta a negociar os limites com o filho em vez de impô-los unilateralmente.

**Relação com o aplicativo**
Julia não interage com o AntiTela em tempo real, ela recebe o Relatório Semanal em
PDF, gerado localmente, com o panorama consolidado de tempo de uso e assiduidade às
metas combinadas, e o usa como ponto de partida para conversas com Lucas sobre ajustes
no "plano de uso de telas" da família, sem qualquer acesso ao conteúdo emocional que
ele registra no Diário de Bordo.

---

## Persona prioritária

**Persona prioritária: Lucas Andrade (adolescente, usuário primário).**

**Justificativa:** o próprio estudo de caso do AntiTela define o adolescente como
"usuário primário" e "operador diário", e a pesquisa reforça essa priorização: mais de
80% dos adolescentes não têm supervisão ativa dos pais durante o uso da internet, e
regras parentais impostas de fora para dentro têm efeito limitado sobre a nomofobia e
o comportamento real do jovem. Um produto pensado primeiro para agradar aos pais
correria o risco de repetir a lógica de vigilância do Google Family Link que a
própria análise crítica do estudo de caso identifica como uma abordagem desgastante e
pouco eficaz. Por isso, toda decisão de produto (Avatar Âncora, Missões Offline,
ausência de bloqueio forçado, privacidade do Diário de Bordo) deve ser validada
primeiro sob a ótica de adesão voluntária do Lucas; a experiência da Julia (Relatório
em PDF) é indispensável, mas funciona como camada de suporte e transparência
complementar, não como o centro do produto.
