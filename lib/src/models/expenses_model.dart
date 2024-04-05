class ExpensesModel {
  final int ano;
  final String cnpjCpfFornecedor;
  final int codDocumento;
  final int codLote;
  final int codTipoDocumento;
  final String dataDocumento;
  final int mes;
  final String nomeFornecedor;
  final String numDocumento;
  final String? numRessarcimento; // Alterado para permitir valor nulo
  final int parcela;
  final String tipoDespesa;
  final String tipoDocumento;
  final String? urlDocumento; // Alterado para permitir valor nulo
  final double valorDocumento;
  final double valorGlosa;
  final double valorLiquido;

  ExpensesModel({
    required this.ano,
    required this.cnpjCpfFornecedor,
    required this.codDocumento,
    required this.codLote,
    required this.codTipoDocumento,
    required this.dataDocumento,
    required this.mes,
    required this.nomeFornecedor,
    required this.numDocumento,
    required this.numRessarcimento,
    required this.parcela,
    required this.tipoDespesa,
    required this.tipoDocumento,
    required this.urlDocumento,
    required this.valorDocumento,
    required this.valorGlosa,
    required this.valorLiquido,
  });

  factory ExpensesModel.fromMap(Map<String, dynamic> map) {
    return ExpensesModel(
      ano: map['ano'] as int ?? 0,
      cnpjCpfFornecedor: map['cnpjCpfFornecedor'] as String ?? '',
      codDocumento: map['codDocumento'] as int ?? 0,
      codLote: map['codLote'] as int ?? 0,
      codTipoDocumento: map['codTipoDocumento'] as int ?? 0,
      dataDocumento: map['dataDocumento'] as String ?? '',
      mes: map['mes'] as int ?? 0,
      nomeFornecedor: map['nomeFornecedor'] as String ?? '',
      numDocumento: map['numDocumento'] as String,
      numRessarcimento: map['numRessarcimento']
          as String?, // Alterado para permitir valor nulo
      parcela: map['parcela'] as int ?? 0,
      tipoDespesa: map['tipoDespesa'] as String ?? '',
      tipoDocumento: map['tipoDocumento'] as String ?? '',
      urlDocumento:
          map['urlDocumento'] as String?, // Alterado para permitir valor nulo
      valorDocumento: map['valorDocumento'] as double ?? 0.0,
      valorGlosa: map['valorGlosa'] as double ?? 0.0,
      valorLiquido: map['valorLiquido'] as double ?? 0.0,
    );
  }
}
