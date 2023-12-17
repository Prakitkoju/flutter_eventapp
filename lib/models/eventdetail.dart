class EventDetail {
  final String name;
  final String dateTime;
  final List<String> images;
  final String info;
  final String pleasenote;
  final List<String> promoters;

  EventDetail({
    required this.name,
    required this.dateTime,
    required this.images,
    required this.info,
    required this.pleasenote,
    required this.promoters,
  });

  factory EventDetail.fromJson(Map<String, dynamic> json) {
    return EventDetail(
      name: json['name'],
      dateTime: json['dates']['start']['localDate'],
      // image: json['images'][0]['url'],
      images: json['images']
          .map<String>((image) => image['url'].toString())
          .take(3) // Take the first three images
          .toList(),
      info: json['info'] ?? 'No description available',
      pleasenote: json['pleaseNote'] ?? 'No Note',
      promoters: json['promoters']
          .map<String>((promoter) => promoter['name'].toString())
          .toList(),
    );
  }
}