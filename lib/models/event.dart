class Event {
  final String imageUrl;
  final String name;
  final String dateTime;
  final String id;

  Event({
    required this.imageUrl,
    required this.name,
    required this.dateTime,
    required this.id,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      imageUrl: json['images'][0]['url'],
      name: json['name'],
      dateTime: json['dates']['start']['localDate'],
      id: json['id'],
    );
  }
}
