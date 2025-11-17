// Langkah 1: Buka pizza.dart dan Buat Konstanta
// Deklarasi konstanta untuk setiap kunci JSON di luar class Pizza
const keyId = 'id';
const keyName = 'pizzaName';
const keyDescription = 'description';
const keyPrice = 'price';
const keyImage = 'imageUrl';

class Pizza {
  final int id;
  final String pizzaName;
  final String description;
  final double price;
  final String imageUrl;

  Pizza({
    required this.id,
    required this.pizzaName,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  // Langkah 2: Perbarui fromJson() menggunakan Konstanta
  factory Pizza.fromJson(Map<String, dynamic> json) {
    // Penanganan ID (int)
    final id = int.tryParse(json[keyId]?.toString() ?? '') ?? 0;

    // Penanganan Nama (String) - Menggunakan operator ternary seperti pada Langkah 10 sebelumnya
    final pizzaName = (json[keyName] != null) 
        ? json[keyName].toString() 
        : 'No name';

    // Penanganan Deskripsi (String) - Menggunakan operator ternary seperti pada Langkah 10 sebelumnya
    final description = (json[keyDescription] != null)
        ? json[keyDescription].toString()
        : '';

    // Penanganan Harga (double)
    final price = double.tryParse(json[keyPrice]?.toString() ?? '') ?? 0.0;

    // Penanganan URL Gambar (String) - Menggunakan null coalescing (??)
    final imageUrl = json[keyImage]?.toString() ?? '';

    return Pizza(
      id: id,
      pizzaName: pizzaName,
      description: description,
      price: price,
      imageUrl: imageUrl,
    );
  }

  // Langkah 3: Perbarui toJson() menggunakan Konstanta
  Map<String, dynamic> toJson() {
    return {
      keyId: id,
      keyName: pizzaName,
      keyDescription: description,
      keyPrice: price,
      keyImage: imageUrl,
    };
  }
}