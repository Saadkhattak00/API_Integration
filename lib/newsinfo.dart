import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.pagination,
    this.data,
  });

  Pagination pagination;
  List<Datum> data;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        pagination: Pagination.fromJson(json["pagination"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.author,
    this.title,
    this.description,
    this.url,
    this.source,
    this.image,
    this.category,
    this.language,
    this.country,
    this.publishedAt,
  });

  String author;
  String title;
  String description;
  String url;
  String source;
  String image;
  Category category;
  Language language;
  Country country;
  DateTime publishedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        author: json["author"] == null ? null : json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        source: json["source"],
        image: json["image"] == null ? null : json["image"],
        category: categoryValues.map[json["category"]],
        language: languageValues.map[json["language"]],
        country: countryValues.map[json["country"]],
        publishedAt: DateTime.parse(json["published_at"]),
      );

  Map<String, dynamic> toJson() => {
        "author": author == null ? null : author,
        "title": title,
        "description": description,
        "url": url,
        "source": source,
        "image": image == null ? null : image,
        "category": categoryValues.reverse[category],
        "language": languageValues.reverse[language],
        "country": countryValues.reverse[country],
        "published_at": publishedAt.toIso8601String(),
      };
}

enum Category { GENERAL, BUSINESS, SPORTS }

final categoryValues = EnumValues({
  "business": Category.BUSINESS,
  "general": Category.GENERAL,
  "sports": Category.SPORTS
});

enum Country { US }

final countryValues = EnumValues({"us": Country.US});

enum Language { EN }

final languageValues = EnumValues({"en": Language.EN});

class Pagination {
  Pagination({
    this.limit,
    this.offset,
    this.count,
    this.total,
  });

  int limit;
  int offset;
  int count;
  int total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        limit: json["limit"],
        offset: json["offset"],
        count: json["count"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "count": count,
        "total": total,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
