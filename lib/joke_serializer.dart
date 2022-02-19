
import 'package:json_annotation/json_annotation.dart';

part 'joke_serializer.g.dart';


@JsonSerializable()
class Joke{
  final String icon_url;
  final String id;
  final String url;
  final String value;

  Joke(this.icon_url, this.id, this.url, this.value);

  factory Joke.fromJson(Map<String, dynamic> json) => _$JokeFromJson(json);
  Map<String, dynamic> toJson() => _$JokeToJson(this);
}

@JsonSerializable()
class JokeQuery extends Joke{
  final List<String?> categories;
  final String created_at;
  final String updated_at;

  JokeQuery(
      this.categories,
      this.created_at,
      String icon_url,
      String id,
      this.updated_at,
      String url,
      String value

  ) : super(icon_url, id, url, value);

  factory JokeQuery.fromJson(Map<String, dynamic> json) => _$JokeQueryFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$JokeQueryToJson(this);
}

@JsonSerializable()
class Query{
  final int total;
  final List<JokeQuery> result;

  Query(this.total, this.result);

  factory Query.fromJson(Map<String, dynamic> json) => _$QueryFromJson(json);
  Map<String, dynamic> toJson() => _$QueryToJson(this);
}