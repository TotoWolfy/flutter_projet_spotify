class TopTrack {
  final String name;
  final String id;
  final String url;

  TopTrack({
    required this.name,
    required this.id,
    required this.url,
  });

  factory TopTrack.fromJson(Map<String, dynamic> json) {
    return TopTrack(
      name: json['name'] ?? '',
      id: json['id'] ?? '',
      url: json['preview_url'] ?? '',
    );
  }
}
