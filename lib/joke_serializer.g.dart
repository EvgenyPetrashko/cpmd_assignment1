// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke_serializer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Joke _$JokeFromJson(Map<String, dynamic> json) => Joke(
      json['icon_url'] as String,
      json['id'] as String,
      json['url'] as String,
      json['value'] as String,
    );

Map<String, dynamic> _$JokeToJson(Joke instance) => <String, dynamic>{
      'icon_url': instance.icon_url,
      'id': instance.id,
      'url': instance.url,
      'value': instance.value,
    };

JokeQuery _$JokeQueryFromJson(Map<String, dynamic> json) => JokeQuery(
      (json['categories'] as List<dynamic>).map((e) => e as String?).toList(),
      json['created_at'] as String,
      json['icon_url'] as String,
      json['id'] as String,
      json['updated_at'] as String,
      json['url'] as String,
      json['value'] as String,
    );

Map<String, dynamic> _$JokeQueryToJson(JokeQuery instance) => <String, dynamic>{
      'icon_url': instance.icon_url,
      'id': instance.id,
      'url': instance.url,
      'value': instance.value,
      'categories': instance.categories,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };

Query _$QueryFromJson(Map<String, dynamic> json) => Query(
      json['total'] as int,
      (json['result'] as List<dynamic>)
          .map((e) => JokeQuery.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QueryToJson(Query instance) => <String, dynamic>{
      'total': instance.total,
      'result': instance.result,
    };
