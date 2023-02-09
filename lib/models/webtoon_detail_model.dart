class WebtoonDetailModel {
  final String title, about, genre, age, thumb;
  final String id;

  WebtoonDetailModel.fromJson(Map<String, dynamic> json, this.id)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        thumb = json['thumb'],
        age = json['age'];
}
