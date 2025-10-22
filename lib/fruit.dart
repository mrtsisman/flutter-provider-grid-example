class Fruit {
  final String title;
  final String image;

  Fruit({required this.title, required this.image});

  Map<String, dynamic> toJson() => {'title': title, 'image': image};

  factory Fruit.fromJson(Map<String, dynamic> json) =>
      Fruit(title: json['title'], image: json['image']);
}

