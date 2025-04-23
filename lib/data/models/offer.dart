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

class OfferPagination {
  final int totalCount;
  final int pageSize;
  final int currentPage;
  final int pageCount;

  OfferPagination({
    required this.totalCount,
    required this.pageSize,
    required this.currentPage,
    required this.pageCount,
  });

  factory OfferPagination.fromJson(Map<String, dynamic> json) {
    return OfferPagination(
      totalCount: json['total_count'] ?? 0,
      pageSize: json['page_size'] ?? 0,
      currentPage: json['current_page'] ?? 0,
      pageCount: json['page_count'] ?? 0,
    );
  }
}

class OffersResponse {
  final List<Offer> offers;
  final OfferPagination pagination;

  OffersResponse({
    required this.offers,
    required this.pagination,
  });

  factory OffersResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> infoList = json['info'] ?? [];
    final List<Offer> offers = infoList.map((item) => Offer.fromJson(item)).toList();

    return OffersResponse(
      offers: offers,
      pagination: OfferPagination.fromJson(json['pagination'] ?? {}),
    );
  }
}
