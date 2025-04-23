class Offer {
  final String id;
  final String name;
  final String previewPicture;
  final String price;
  final String oldPrice;
  final String percent;
  final int reviewsCount;
  final int rating;
  final bool inFavourites;

  Offer({
    required this.id,
    required this.name,
    required this.previewPicture,
    required this.price,
    required this.oldPrice,
    required this.percent,
    required this.reviewsCount,
    required this.rating,
    required this.inFavourites,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      previewPicture: json['preview_picture']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      oldPrice: json['old_price']?.toString() ?? '',
      percent: json['percent']?.toString() ?? '',
      reviewsCount: json['reviews_count'] ?? 0,
      rating: json['rating'] ?? 0,
      inFavourites: json['in_favourites'] ?? false,
    );
  }
}