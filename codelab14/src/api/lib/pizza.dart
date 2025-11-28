class Pizza {
  final int id;
  final String pizzaName;
  final String description;
  final double price;
  final String imageUrl;
  final String category; // Soal 2: Field Baru

  Pizza({
    required this.id,
    required this.pizzaName,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: json['id'] ?? 0,
      pizzaName: json['pizzaname'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] ?? 0.0),
      imageUrl: json['imageurl'] ?? '',
      category: json['category'] ?? 'Unknown', // Soal 2: Ambil kategori
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pizzaname': pizzaName,
      'description': description,
      'price': price,
      'imageurl': imageUrl,
      'category': category, // Soal 2: Kirim kategori
    };
  }
}