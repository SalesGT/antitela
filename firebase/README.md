# Banco de dados do AntiTela (Firebase / Firestore)

Traduz o diagrama `docs/antitelaDB.pdf` (modelo relacional) para o Firestore (NoSQL).
O app **não tem cadastro**: usa *login anônimo* do Firebase Auth. O Firebase gera um `uid`
aleatório e é com ele que os dados da pessoa ficam separados. Só guardamos **nome e idade**.

## Estrutura

```
usuarios/{uid}                      nome, idade, tipo, criado_em
  ├─ avatar/atual                   nome_mascote, status_humor, dias_protegidos, escudos
  ├─ sessoes_foco/{id}              duracao_minutos, tipo_ciclo, horario_inicio, concluida
  ├─ missoes_offline/{id}           titulo, recompensa_bonus, concluida
  └─ registros_diario/{id}          timestamp, bateria_mental, desabafo_privado?, tags[]
tags_contexto/{slug}                nome
```

## Do PDF para o Firestore

| Tabela do PDF      | No Firestore                          | O que mudou |
|--------------------|---------------------------------------|-------------|
| `usuarios`         | `usuarios/{uid}`                      | **Novo campo `idade`** (não estava no PDF). `id` = uid anônimo. |
| `avatares`         | `usuarios/{uid}/avatar/atual`         | Relação 1:1 vira um único documento fixo. |
| `sessoes_foco`     | `usuarios/{uid}/sessoes_foco/{id}`    | `usuario_id` virou o caminho (subcoleção). |
| `missoes_offline`  | `usuarios/{uid}/missoes_offline/{id}` | idem |
| `registros_diario` | `usuarios/{uid}/registros_diario/{id}`| idem |
| `registro_tags`    | campo `tags` (lista de ids) em cada registro | A tabela de junção N:N deixa de existir. |
| `tags_contexto`    | `tags_contexto/{slug}`                | Id = slug (ex.: `tiktok`), o que garante `nome` único. |

Valores aceitos (conferidos também nas regras de segurança):

- `usuarios.tipo`: `adolescente`
- `avatar.status_humor`: `saudavel` · `cansado` · `esgotado`
- `sessoes_foco.tipo_ciclo`: `pomodoro` (25) · `profundo` (45) · `noturno` (60)
- `registros_diario.bateria_mental`: `suave` · `cansado` · `frito`

## Regras de segurança (`firestore.rules`)

Cada pessoa lê/escreve **só o próprio** `usuarios/{uid}`. A matriz CRUD do `requisitos.md` (2.4) está imposta no servidor:

| Coleção            | Criar | Ler | Atualizar | Excluir |
|--------------------|:----:|:---:|:---------:|:-------:|
| missoes_offline    | ✔ | ✔ | ✔ | ✔ |
| registros_diario   | ✔ | ✔ | ✘ | ✔ |
| sessoes_foco       | ✔ | ✔ | ✘ | ✔ |
| avatar             | ✔ | ✔ | ✔ | só ao apagar a conta |
| tags_contexto      | ✘ | ✔ | ✘ | ✘ |

Como sessões não podem ser atualizadas, o app grava a sessão **quando ela termina** (concluída ou desistida).

## Configuração (uma vez)

1. [console.firebase.google.com](https://console.firebase.google.com) → **Criar projeto** (ex.: `antitela`).
2. **Authentication → Método de login → Anônimo → Ativar.**
3. **Firestore Database → Criar banco** → modo produção → região `southamerica-east1` (São Paulo).
4. Na pasta `docs/` (onde está o `pubspec.yaml`):
   ```
   npm install -g firebase-tools
   dart pub global activate flutterfire_cli
   firebase login
   flutterfire configure
   flutter pub get
   ```
   O `flutterfire configure` **substitui** o placeholder `lib/firebase_options.dart` e ajusta o Gradle do Android.
5. Publicar as regras: `firebase deploy --only firestore:rules` (ou copie `firestore.rules` no console → Firestore → Regras).
6. Popular as tags (uma vez): siga o cabeçalho de `seed_tags.js`.

> O primeiro acesso de cada pessoa precisa de internet (para o login anônimo). Depois disso o app funciona offline e sincroniza sozinho.

## Atenção: privacidade

- `desabafo_privado` (texto livre do diário) é gravado no Firestore, mas só o próprio usuário consegue ler (regras) e ele **nunca entra no PDF** dos pais. O RNF03 do `requisitos.md` e o aviso da tela Diário já foram atualizados para refletir isso.
- Faixa etária: o app aceita 12 a 18 anos (`Usuario.idadeMinima/idadeMaxima` e `firestore.rules`). Abaixo de 12 anos a LGPD (art. 14) exige consentimento específico de um responsável.
- Login anônimo: se a pessoa desinstalar o app ou limpar os dados, perde o acesso ao que gravou.
- `AntiTelaRepository.apagarTodosOsDados()` remove tudo da nuvem e do aparelho (RF12).
