enum PackageState {
  almacenMiami,
  embarcado,
  aduanaAila,
  contenedorSucursal,
  enCamino,
  entregado,
}

class PackageModel {
  final String id;
  final String categoria;
  final String guia;
  final String tracking;
  final double peso;
  final double monto;
  final DateTime fechaLlegada;
  final DateTime fechaExpected;
  final PackageState estado;
  final bool tieneRetraso;

  const PackageModel({
    required this.id,
    required this.categoria,
    required this.guia,
    required this.tracking,
    required this.peso,
    required this.monto,
    required this.fechaLlegada,
    required this.fechaExpected,
    required this.estado,
    required this.tieneRetraso,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'] as String,
      categoria: json['categoria'] as String,
      guia: json['guia'] as String,
      tracking: json['tracking'] as String,
      peso: (json['peso'] as num).toDouble(),
      monto: (json['monto'] as num).toDouble(),
      fechaLlegada: DateTime.parse(json['fechaLlegada'] as String),
      fechaExpected: DateTime.parse(json['fechaExpected'] as String),
      estado: PackageState.values.firstWhere(
        (e) => e.name == json['estado'],
        orElse: () => PackageState.almacenMiami,
      ),
      tieneRetraso: json['tieneRetraso'] as bool? ?? false,
    );
  }
}
