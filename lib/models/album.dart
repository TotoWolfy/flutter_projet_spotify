class Album {
  String name;
  String href;
  List<String> images;
  String id;

  Album({required this.name, required this.href, required this.images, required this.id});

  factory Album.fromJson(Map<String, dynamic> data) {
     List<String> url = [];
    if (data.containsKey('images')) {
      data['images'].forEach((image) {
        url.add(image['url']);
      });
    }


    return Album(
      name: data['name'],
      href: data['href'],
      images: url,
      id : data['id']
    );
  }
}