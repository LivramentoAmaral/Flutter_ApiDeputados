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
  final String numRessarcimento;
  final int parcela;
  final String tipoDespesa;
  final String tipoDocumento;
  final String urlDocumento;
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
      ano: map['ano'] as int,
      cnpjCpfFornecedor: map['cnpjCpfFornecedor'] as String,
      codDocumento: map['codDocumento'] as int,
      codLote: map['codLote'] as int,
      codTipoDocumento: map['codTipoDocumento'] as int,
      dataDocumento: map['dataDocumento'] as String,
      mes: map['mes'] as int,
      nomeFornecedor: map['nomeFornecedor'] as String,
      numDocumento: map['numDocumento'] as String,
      numRessarcimento: map['numRessarcimento'] as String,
      parcela: map['parcela'] as int,
      tipoDespesa: map['tipoDespesa'] as String,
      tipoDocumento: map['tipoDocumento'] as String,
      urlDocumento: map['urlDocumento'] as String,
      valorDocumento: map['valorDocumento'] as double,
      valorGlosa: map['valorGlosa'] as double,
      valorLiquido: map['valorLiquido'] as double,
    );
  }
}
