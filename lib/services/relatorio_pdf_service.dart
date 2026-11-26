import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../data/antitela_repository.dart';
import '../models/avatar.dart';
import '../models/missao_offline.dart';
import '../models/sessao_foco.dart';
import '../models/usuario.dart';

/// RF08: relatorio semanal em PDF, gerado no proprio aparelho.
/// Inclui foco, missoes e escudos. O Diario de Bordo e PRIVADO e fica de fora.
class RelatorioPdfService {
  RelatorioPdfService({AntiTelaRepository? repository})
      : _repo = repository ?? AntiTelaRepository();

  final AntiTelaRepository _repo;

  /// Gera o PDF e abre a folha de compartilhar/salvar do sistema.
  Future<void> exportarSemanal({int dias = 7}) async {
    final bytes = await gerarSemanal(dias: dias);
    await Printing.sharePdf(
      bytes: bytes,
      filename: 'antitela-relatorio-semanal.pdf',
    );
  }

  Future<Uint8List> gerarSemanal({int dias = 7}) async {
    final fim = DateTime.now();
    final hoje = DateTime(fim.year, fim.month, fim.day);
    final inicio = hoje.subtract(Duration(days: dias - 1));

    final usuario = await _repo.carregarUsuario();
    final avatar = await _repo.avatar().first;
    final sessoes = await _repo.sessoes(desde: inicio).first;
    final missoes = await _repo.missoes().first;

    return _montar(
      usuario: usuario,
      avatar: avatar ?? const Avatar(),
      sessoes: sessoes,
      missoes: missoes,
      inicio: inicio,
      fim: fim,
    );
  }

  // ───────────────────────────── Montagem do PDF ─────────────────────────────

  static const _roxo = PdfColor.fromInt(0xFF7C3AED);
  static const _cinza = PdfColors.grey700;

  Future<Uint8List> _montar({
    required Usuario? usuario,
    required Avatar avatar,
    required List<SessaoFoco> sessoes,
    required List<MissaoOffline> missoes,
    required DateTime inicio,
    required DateTime fim,
  }) {
    final concluidas = sessoes.where((s) => s.concluida).toList();
    final minutosFoco = concluidas.fold<int>(0, (s, e) => s + e.duracaoMinutos);
    final missoesOk = missoes.where((m) => m.concluida).length;

    final doc = pw.Document(
      title: 'Relatório semanal - AntiTela',
      author: 'AntiTela',
    );

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        build: (_) => [
          pw.Text('AntiTela',
              style: pw.TextStyle(
                  fontSize: 26, fontWeight: pw.FontWeight.bold, color: _roxo)),
          pw.Text('Relatório semanal',
              style: const pw.TextStyle(fontSize: 14, color: _cinza)),
          pw.SizedBox(height: 14),
          pw.Text(
            'Nome: ${usuario?.nome ?? '-'}    Idade: ${usuario?.idade ?? '-'}',
            style: const pw.TextStyle(fontSize: 12),
          ),
          pw.Text('Período: ${_data(inicio)} a ${_data(fim)}',
              style: const pw.TextStyle(fontSize: 12)),
          pw.SizedBox(height: 18),
          pw.Row(children: [
            _cartao('Sessões de foco concluídas',
                '${concluidas.length} de ${sessoes.length}'),
            pw.SizedBox(width: 8),
            _cartao('Minutos em foco', '$minutosFoco'),
          ]),
          pw.SizedBox(height: 8),
          pw.Row(children: [
            _cartao('Missões concluídas', '$missoesOk de ${missoes.length}'),
            pw.SizedBox(width: 8),
            _cartao('Escudos do avatar', '${avatar.escudos}'),
          ]),
          pw.SizedBox(height: 22),
          _titulo('Sessões de foco'),
          if (sessoes.isEmpty)
            _vazio('Nenhuma sessão registrada no período.')
          else
            _tabela(
              cabecalho: ['Data', 'Duração', 'Ciclo', 'Situação'],
              linhas: [
                for (final s in sessoes)
                  [
                    _dataHora(s.horarioInicio),
                    '${s.duracaoMinutos} min',
                    _nomeCiclo(s.tipoCiclo),
                    s.concluida ? 'Concluída' : 'Interrompida',
                  ],
              ],
            ),
          pw.SizedBox(height: 22),
          _titulo('Missões offline'),
          if (missoes.isEmpty)
            _vazio('Nenhuma missão cadastrada.')
          else
            _tabela(
              cabecalho: ['Missão', 'Escudos', 'Situação'],
              linhas: [
                for (final m in missoes)
                  [
                    m.titulo,
                    '${m.recompensaBonus}',
                    m.concluida ? 'Concluída' : 'Pendente',
                  ],
              ],
            ),
          pw.SizedBox(height: 28),
          pw.Text(
            'O Diário de Bordo é privado e não faz parte deste relatório.',
            style: const pw.TextStyle(fontSize: 10, color: _cinza),
          ),
        ],
      ),
    );

    return doc.save();
  }

  pw.Widget _titulo(String texto) => pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 6),
        child: pw.Text(texto,
            style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
      );

  pw.Widget _vazio(String texto) => pw.Text(texto,
      style: const pw.TextStyle(fontSize: 11, color: _cinza));

  pw.Widget _cartao(String rotulo, String valor) => pw.Expanded(
        child: pw.Container(
          padding: const pw.EdgeInsets.all(10),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey400),
            borderRadius: pw.BorderRadius.circular(6),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(rotulo,
                  style: const pw.TextStyle(fontSize: 10, color: _cinza)),
              pw.SizedBox(height: 4),
              pw.Text(valor,
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
            ],
          ),
        ),
      );

  pw.Widget _tabela({
    required List<String> cabecalho,
    required List<List<String>> linhas,
  }) {
    pw.Widget celula(String t, {bool negrito = false}) => pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: pw.Text(
            t,
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: negrito ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        );

    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: [for (final c in cabecalho) celula(c, negrito: true)],
        ),
        for (final linha in linhas)
          pw.TableRow(children: [for (final c in linha) celula(c)]),
      ],
    );
  }

  String _nomeCiclo(String ciclo) {
    switch (ciclo) {
      case SessaoFoco.cicloPomodoro:
        return 'Pomodoro (25 min)';
      case SessaoFoco.cicloProfundo:
        return 'Foco profundo (45 min)';
      case SessaoFoco.cicloNoturno:
        return 'Sem telas / Noturno (60 min)';
      default:
        return ciclo;
    }
  }

  String _dois(int n) => n.toString().padLeft(2, '0');
  String _data(DateTime d) => '${_dois(d.day)}/${_dois(d.month)}/${d.year}';
  String _dataHora(DateTime d) =>
      '${_data(d)} ${_dois(d.hour)}:${_dois(d.minute)}';
}
