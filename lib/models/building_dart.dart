class Building {
  final String id;
  final String name;
  final String number;

  Building({required this.id, required this.name, required this.number});

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
        id: json['id'].toString(),
        name: json['building_name'],
        number: json['number_of_building'].toString());
  }
}
