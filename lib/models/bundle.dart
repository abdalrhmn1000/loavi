class Bundle {
  final int id;
  final String name;
  final String description;
  final String price;
  List<String>? features;

  Bundle(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      this.features});

  factory Bundle.fromJson(
    Map<String, dynamic> json,
    Map<String, dynamic> json2,
  ) {
    return Bundle(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json2['price'],
        features : json['features'].cast<String>());
  }
}
