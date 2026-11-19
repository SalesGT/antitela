import 'package:cloud_firestore/cloud_firestore.dart';

/// Converte um campo `timestamp` do Firestore em [DateTime].
/// Devolve null quando o valor ainda nao existe (ex.: serverTimestamp pendente offline).
DateTime? dataDe(Object? valor) => valor is Timestamp ? valor.toDate() : null;
