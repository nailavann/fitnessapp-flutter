import 'dart:convert';

Body vucutFromMap(String str) => Body.fromMap(json.decode(str));

String vucutToMap(Body data) => json.encode(data.toMap());

class Body {
  Body({
    required this.vucutBolge,
    required this.vucutFoto,
    required this.vucutDetay,
  });

  final String vucutBolge;
  final String vucutFoto;
  final List<BodyDetail> vucutDetay;

  factory Body.fromMap(Map<String, dynamic> json) => Body(
        vucutBolge: json["vucut_bolge"],
        vucutFoto: json["vucut_foto"],
        vucutDetay: List<BodyDetail>.from(
            json["vucut_detay"].map((x) => BodyDetail.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "vucut_bolge": vucutBolge,
        "vucut_foto": vucutFoto,
        "vucut_detay": List<dynamic>.from(vucutDetay.map((x) => x.toMap())),
      };
}

class BodyDetail {
  BodyDetail({
    required this.hareketAdi,
    required this.teknik,
    required this.foto,
  });

  final String hareketAdi;
  final String teknik;
  final List<String> foto;

  factory BodyDetail.fromMap(Map<String, dynamic> json) => BodyDetail(
        hareketAdi: json["hareket_adi"],
        teknik: json["teknik"],
        foto: List<String>.from(json["foto"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "hareket_adi": hareketAdi,
        "teknik": teknik,
        "foto": List<dynamic>.from(foto.map((x) => x)),
      };
}
