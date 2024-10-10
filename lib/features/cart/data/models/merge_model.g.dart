// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MergeModel _$MergeModelFromJson(Map<String, dynamic> json) => MergeModel(
      mainUser: (json['main_user'] as num).toInt(),
      users: (json['users'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$MergeModelToJson(MergeModel instance) =>
    <String, dynamic>{
      'main_user': instance.mainUser,
      'users': instance.users,
    };
