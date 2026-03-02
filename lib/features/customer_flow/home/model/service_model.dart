class ServiceModel {
  final int id;
  final String name;
  final String price;
  final String description;
  final String category;
  final double distanceKm;
  final String imagePath; // e.g. 'assets/images/garden.jpg'

  const ServiceModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.distanceKm,
    this.imagePath = '',
  });
}

enum ServiceCategory { popular, seasonal, all, offer }