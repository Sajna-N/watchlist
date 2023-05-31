class Persons {
  final String id;
  final String name;
  final String contacts;
  String? url;

  Persons({
    required this.id,
    required this.name,
    required this.contacts,
    this.url,
  });

  factory Persons.fromJson(Map<String, dynamic> json) {
    return Persons(
        id: json['id'],
        name: json['name'],
        contacts: json['Contacts'],
        url: json['url']);
  }
}
