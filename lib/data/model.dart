import 'dart:convert';

class Model {
  String filepath;
  int priceperkg;
  int quantity;
  String vegetablename;
  Model(this.filepath, this.priceperkg, this.quantity, this.vegetablename);

  @override
  String toString() {
    return '{${this.filepath},${this.priceperkg},${this.quantity},${this.vegetablename}}';
  }

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(json['filepath'], json['priceperkg'], json['quantity'],
        json['vegetablename']);
  }

  static String encodeModels(List<Model> model) => json.encode(
        model.map<Map<String, dynamic>>((model) => Model.toMap(model)).toList(),
      );

  static List<Model> decodeModels(String models) =>
      (json.decode(models) as List<dynamic>)
          .map<Model>((item) => Model.fromJson(item))
          .toList();

  static Map<String, dynamic> toMap(Model model) => {
        'filepath': model.filepath,
        'priceperkg': model.priceperkg,
        'quantity': model.quantity,
        'vegetablename': model.vegetablename
      };
  Map toJson() => {
        'filepath': filepath,
        'priceperkg': priceperkg,
        'quantity': quantity,
        'vegetablename': vegetablename
      };
}
