# Pesquisa — AntiTela

**Projeto:** AntiTela — aplicativo de autorregulação do tempo de tela para adolescentes
**Disciplina:** Programação para Dispositivos Móveis
**Arquivo de destino no repositório:** `docs/pesquisa.md`

---

## 1. Objetivo da pesquisa

Esta pesquisa aprofunda o entendimento do problema enfrentado pelo AntiTela: o uso
excessivo, desregulado e compulsivo de smartphones e redes sociais por adolescentes,
e a ineficácia dos métodos tradicionais de controle parental (bloqueios arbitrários,
espionagem, punição), que geram conflito familiar sem desenvolver autorregulação real
no jovem. A pesquisa feita mostra o motivo das decisões já tomadas no estudo de caso do projeto como a opção por gamificação empática (Avatar Âncora) em vez de bloqueio forçado e por privacidade estrita do Diário de Bordo. Fazendo com que o aplicativo tenha um incentivo natural, permitindo assim a criação de hábitos saudáveis de controle de tela sem perder o direito de individualidade.

---

## 2. O problema

### 2.1 Escala do uso de telas entre adolescentes no Brasil

O Brasil está entre os países com maior tempo de tela do mundo. Segundo dados do Comitê
Gestor da Internet no Brasil (CGI.br), citados pelo Centro Universitário Tiradentes
(Unit-PE), cerca de 95% das pessoas entre 9 e 17 anos utilizam celular no país, com
média de uso de pelo menos nove horas diárias, um dos fatores que levou à sanção da
Lei Federal nº 15.100/2025, que restringe o uso de celulares em escolas de educação
básica. A pesquisa *TIC Kids Online Brasil 2024* mostra que 93% da população de 9 a 17
anos já é usuária de internet no país.

Um estudo publicado na *Revista Panamericana de Salud Pública* (2025), com 214
adolescentes de escola pública, detalha o padrão de uso: 76,4% usavam o celular por
mais de 4 horas/dia em dias letivos (80,5% em dias não letivos); 81,5% relataram
ausência de supervisão parental na internet; e 90,6% relataram uso do celular em sala
de aula.

### 2.2 Higiene do sono e saúde física — a base científica do problema

O AntiTela parte da premissa de que o problema vai além do número de horas em tela.
As diretrizes atualizadas (2024) da **Sociedade Brasileira de Pediatria (SBP)**
recomendam que adolescentes de 11 a 18 anos limitem o uso de telas a duas ou três horas
diárias, com desligamento dos dispositivos de uma a duas horas antes de dormir, e
recomendam ainda a criação de um "plano de uso de mídias" em família, incluindo quartos
como zonas livres de tecnologia.

Essa recomendação tem base fisiológica: a exposição à luz de espectro azul nas horas
que antecedem o sono interfere na produção de melatoninna, hormônio cuja liberação é
estimulada pela escuridão e suprimida pela luz, atrasando o início do sono. Fontes
médicas (SBP; Afya) apontam que restringir o tempo de tela na hora anterior ao sono é
recomendado como tratamento de primeira linha para dificuldades de início do sono em
crianças e adolescentes, e que a privação de sono resultante prejudica a consolidação da memória, o rendimento escolar e a regulação do humor. A SBP também alerta que o uso
excessivo de telas está associado a sedentarismo, problemas de saúde ocular pela
exposição prolongada à luz azul, e a uma lista mais ampla de riscos que inclui
dependência digital, transtornos do sono e transtornos de imagem corporal.

### 2.3 Nomofobia, FOMO e o fracasso da abordagem puramente punitiva

A literatura recente descreve dois fenômenos centrais no uso compulsivo de smartphones
por jovens:

- **Nomofobia** — o medo ou desconforto de ficar sem acesso ao smartphone. Um estudo
  espanhol com jovens de 18 a 25 anos (*Nomofobia y FoMO en el uso del smartphone en
  jóvenes*, Universidade de Oviedo, 2023) encontrou relação positiva entre maior uso do
  celular, maior nomofobia e maior ansiedade.
- **FOMO** (*Fear of Missing Out*) — a ansiedade de estar desconectado das redes
  sociais e "perder" algo relevante que está acontecendo entre os pares associada por
  esse mesmo estudo aos mesmos sintomas de ansiedade.

Um estudo português (Universidade de Coimbra) sobre nomofobia em adolescentes traz um
achado especialmente relevante para o AntiTela: quando os pais impõem regras rígidas
sobre o uso do smartphone, os níveis de nomofobia entre os adolescentes não
necessariamente diminuem de forma proporcional reforçando que regras impostas de fora
para dentro, sem adesão voluntária do jovem, têm efeito limitado sobre o comportamento
real. Esse achado é a base científica para a decisão de projeto de não utilizar bloqueio forçado do sistema no AntiTela.

### 2.4 Problemas no desenvolvimento educacional por causa do uso excessivo de IA

Pesquisas apontam uso excessivo do uso de IA no Brasil na educação, cerca de 60% dos alunos apresentam o uso de IA como fonte principal de pesquisa e que 90% dos professores ja usaram IA para ajudar a criar plano de aula. Mas segundo Ana Luísa Prado, da MegaEdu (2026, s.p) os alunos que usam I.A para pesquisa, em grande parte, apresentam falta de conhecimento tecnológico e no assunto abordado, ou seja, eles estão pesquisando e respondendo, mas não estão aprendendo  

---

## 3. Necessidades e dificuldades dos usuários

- **Falta de consciência sobre o próprio tempo de uso** — o primeiro obstáculo é tornar
  esse dado visível ao próprio adolescente, não apenas ao responsável.
- **Ausência de supervisão e diálogo familiar** — mais de 80% dos adolescentes relatam
  não ter supervisão ativa dos pais durante o uso da internet.
- **Rejeição a controle imposto e vigilância** — a literatura sobre nomofobia e a
  observação direta do comportamento de adolescentes (contornar bloqueadores, burlar
  regras) mostram que soluções puramente punitivas geram resistência ativa, sem
  desenvolver autorregulação.
- **Privação de sono por uso noturno** — recomendação da SBP de desligar telas de 1 a 2
  horas antes de dormir é sistematicamente descumprida, com impacto direto em memória,
  humor e desempenho escolar.
- **Ansiedade de desconexão (FOMO/nomofobia)** — o jovem não consome tela apenas por
  entretenimento, mas por uma necessidade emocional de manter vínculo social com os
  pares, o que exige uma solução que acolha essa necessidade em vez de simplesmente
  cortá-la.

---

## 4. Dados que influenciam diretamente o aplicativo

| Dado | Fonte | Implicação para o AntiTela |
|---|---|---|
| 95% dos jovens de 9–17 anos usam celular, média de 9h/dia | CGI.br / Unit-PE | Produto precisa ser simples e de adoção ampla, não de nicho |
| 81,5% sem supervisão parental na internet | RPSP, 2025 | Autorregulação (Avatar/missões) é tão importante quanto o painel dos pais |
| SBP recomenda desligar telas 1–2h antes de dormir; luz azul suprime melatonina | SBP / Afya | Justifica o Modo Foco noturno e o Dark Mode nativo já definidos no projeto |
| Regras parentais rígidas não reduzem proporcionalmente a nomofobia | Univ. Coimbra | Justifica a decisão de **não** usar bloqueio forçado do sistema |
| Maior uso do celular prediz maior nomofobia e FOMO | Univ. Oviedo, 2023 | Justifica o Diário de Bordo como ferramenta de autopercepção emocional |

---

## 5. Fontes utilizadas / Referências bibliográficas

*(Acesso a todas as fontes em: 09 set. 2025.)*

1. BRASIL. Secretaria de Comunicação Social da Presidência da República. **Governo lança
   guia para uso saudável de telas por crianças e adolescentes.** Brasília, 11 mar. 2025.
   Disponível em: https://www.gov.br/secom/pt-br/assuntos/noticias/2025/03/governo-lanca-guia-para-uso-saudavel-de-telas-por-criancas-e-adolescentes.

2. CENTRO UNIVERSITÁRIO TIRADENTES (Unit-PE). **Uso de celular entre crianças e
   adolescentes é de quase 100% no Brasil.** Dados do CGI.br.
   Disponível em: https://pe.unit.br/blog/noticias/uso-de-celular-entre-criancas-e-adolescente-e-de-quase-100-no-brasil/.

3. **Uso de telas por adolescentes femininas no Brasil: práticas e percepções.**
   Revista Panamericana de Salud Pública, v. 49, e17, jun. 2025. DOI: 10.26633/RPSP.2025.17.
   Disponível em: https://www.scielosp.org/article/rpsp/2025.v49/e17/ (texto completo:
   https://pmc.ncbi.nlm.nih.gov/articles/PMC12007384/).

4. INSTITUTO DE LONGEVIDADE. **Uso excessivo de redes sociais por adolescentes** — estudo
   longitudinal publicado em *Pediatrics Open Science* (2018–2025).
   Disponível em: https://institutodelongevidade.org/longevidade-e-saude/saude-mental/uso-excessivo-de-redes-sociais-por-adolescentes.

5. SANTIAGO, Roberta. **Uso de redes sociais está ligado a 45% dos casos de ansiedade
   entre jovens.** Portal Afya, 22 nov. 2024. Com base no Panorama da Saúde Mental 2024
   (Instituto Cactus / AtlasIntel).
   Disponível em: https://portal.afya.com.br/saude/uso-de-redes-sociais-esta-ligado-a-45-dos-casos-de-ansiedade-entre-jovens.

6. SOCIEDADE BRASILEIRA DE PEDIATRIA (SBP). **Diretrizes sobre uso de telas por crianças
   e adolescentes** (atualização 2024) e **Manual de saúde de crianças e adolescentes na
   era digital.** São Paulo: SBP, 2021.
   Disponível em: https://www.sbp.com.br/pediatria-para-familias/cuidados-com-a-saude/privacao-de-sono-na-populacao-pediatrica/.

7. PORTAL AFYA. **Melatonina e insônia em pediatria** — comentários da SBP sobre uso de
   telas, luz azul e supressão da melatonina.
   Disponível em: https://portal.afya.com.br/pediatria/melatonina-e-insonia-em-pediatria.

8. BRAÑA SÁNCHEZ, Álvaro Jesús; MORAL JIMÉNEZ, María de la Villa. **Nomofobia y FoMO en
   el uso del smartphone en jóvenes: el rol de la ansiedad por estar conectado.** Health
   and Addictions/Salud y Drogas, v. 23, n. 1, p. 117-130, 2023. DOI: 10.21134/haaj.v23i1.707.
   Disponível em: https://portalinvestigacion.uniovi.es/documentos/63dc629c36479d3e033d287d?lang=en.

9. Estudo sobre nomofobia, vinculação e autodano em adolescentes portugueses.
   Universidade de Coimbra, Repositório Científico.
   Disponível em: https://estudogeral.sib.uc.pt/handle/10316/96479?locale=en.

10. **Impactos das redes sociais na saúde mental de jovens: um estudo bibliográfico.**
    Revista da UTFPR. Disponível em:
    https://periodicos.utfpr.edu.br/rtr/article/downloadSuppFile/20013/4192.
   
11. TATI MAGALHÃES. **FL Convida debate o uso responsável da Inteligência Artificial e o letramento digital na Educação Básica.** Disponível em: <https://fundacaolemann.org.br/noticias/inteligencia-artificial-educacao/>. Acesso em: 9 set.. 2026.


---

## 6. Três descobertas importantes e sua influência no projeto

**1. O problema é fisiológico, não apenas comportamental — e isso justifica o Modo
Foco e o Dark Mode do AntiTela.** A recomendação da SBP de desligar telas de 1 a 2 horas
antes de dormir, associada à supressão da melatonina pela luz azul, dá base científica
direta a duas decisões já tomadas no projeto: a interface em Dark Mode nativo (para
ambientes de baixa luz) e o Modo Foco com silenciamento de notificações no período
noturno, sem necessidade de bloquear o aparelho de forma autoritária.

**2. Regras impostas de fora para dentro têm efeito limitado — o que confirma a
escolha por gamificação em vez de bloqueio forçado.** O achado de que regras parentais
rígidas não reduzem proporcionalmente a nomofobia mostra que o AntiTela está no caminho
certo ao rejeitar bloqueadores autoritários (como aponta o próprio estudo de caso) e
apostar no Avatar Âncora e nas Missões Offline como mecanismos de adesão voluntária.

**3. A ansiedade de desconexão (FOMO/nomofobia) é uma necessidade emocional real, não
"frescura" do adolescente.** Isso reforça a importância do Diário de Bordo Pós-Tela
como ferramenta central de autopercepção — permitindo ao jovem relacionar o próprio
estado emocional ao consumo de tela — e reforça por que a privacidade absoluta desse
diário (sem envio ao relatório dos pais) é um requisito não negociável: qualquer
suspeita de vigilância anularia a função terapêutica do recurso.
