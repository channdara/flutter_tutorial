class NewsEventResponse {
  NewsEventResponse(
    this.code,
    this.description,
    this.data,
  );

  factory NewsEventResponse.from(dynamic data) {
    return NewsEventResponse(
      int.tryParse(data['code'].toString()) ?? 0,
      data['description'].toString(),
      NewsEvent.fromList(data['data']),
    );
  }

  final int code;
  final String description;
  final List<NewsEvent> data;
}

class NewsEvent {
  NewsEvent(
    this.id,
    this.title,
    this.description,
    this.image,
    this.date,
  );

  factory NewsEvent.from(dynamic data) {
    return NewsEvent(
      int.tryParse(data['id'].toString()) ?? 0,
      data['title'].toString(),
      data['description'].toString(),
      data['image'].toString(),
      data['date'].toString(),
    );
  }

  static List<NewsEvent> fromList(dynamic data) {
    try {
      return (data as List<dynamic>).map((e) => NewsEvent.from(e)).toList();
    } catch (_) {
      return [];
    }
  }

  final int id;
  final String title;
  final String description;
  final String image;
  final String date;
}
