// Popula a colecao `tags_contexto` (tabela de referencia do diario).
// As regras do Firestore nao deixam o app escrever aqui, entao rode UMA vez:
//
//   cd firebase
//   npm install firebase-admin
//   set GOOGLE_APPLICATION_CREDENTIALS=caminho\para\chave-de-servico.json   (Windows)
//   export GOOGLE_APPLICATION_CREDENTIALS=caminho/para/chave-de-servico.json (Linux/Mac)
//   node seed_tags.js
//
// ATENCAO: a chave de servico e um segredo. NAO coloque no Git.
// O id do documento e o "slug" da tag, por isso rodar de novo nao duplica nada
// (e garante o `unique` do campo nome, como no antitelaDB.pdf).

const admin = require('firebase-admin');

admin.initializeApp({ credential: admin.credential.applicationDefault() });
const db = admin.firestore();

const tags = [
  { id: 'tiktok',    nome: '#TikTok' },
  { id: 'jogos',     nome: '#Jogos' },
  { id: 'tedio',     nome: '#Tédio' },
  { id: 'ansiedade', nome: '#Ansiedade' },
  { id: 'estudos',   nome: '#Estudos' },
  { id: 'serie',     nome: '#Série' },
  { id: 'fomo',      nome: '#FOMO' },
];

(async () => {
  const batch = db.batch();
  for (const { id, nome } of tags) {
    batch.set(db.collection('tags_contexto').doc(id), { nome });
  }
  await batch.commit();
  console.log(`OK: ${tags.length} tags gravadas em tags_contexto.`);
})().catch((e) => { console.error(e); process.exit(1); });
