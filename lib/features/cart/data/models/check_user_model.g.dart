// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUserModel _$CheckUserModelFromJson(Map<String, dynamic> json) =>
    CheckUserModel(
      status: json['status'] as bool? ?? false,
      exodim: json['exodim'] as Map<String, dynamic>? ?? const {},
      statusEXodim: json['status_e_xodim'] as bool? ?? false,
    );

Map<String, dynamic> _$CheckUserModelToJson(CheckUserModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'exodim': instance.exodim,
      'status_e_xodim': instance.statusEXodim,
    };

Exodim _$ExodimFromJson(Map<String, dynamic> json) => Exodim(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? "",
      lastName: json['last_name'] as String? ?? "",
      firstName: json['first_name'] as String? ?? "",
      middleName: json['middle_name'] as String? ?? "",
      photo: json['photo'] as String? ?? "",
      birthday: json['birthday'] as String? ?? "",
      sex: json['sex'] as String? ?? "",
      education: json['education'] as String? ?? "",
      nationality: json['nationality'] as String? ?? "",
      phone: json['phone'] as String? ?? "",
      relatives: (json['relatives'] as List<dynamic>?)
              ?.map((e) => Relative.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      birthPlace: json['birth_place'] as String? ?? "",
      currentPlace: json['current_place'] as String? ?? "",
      positions: (json['positions'] as List<dynamic>?)
              ?.map((e) => Position.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastMed: json['last_med'] ?? "",
      comment: json['comment'] == null
          ? const Comment()
          : Comment.fromJson(json['comment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExodimToJson(Exodim instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'last_name': instance.lastName,
      'first_name': instance.firstName,
      'middle_name': instance.middleName,
      'photo': instance.photo,
      'birthday': instance.birthday,
      'sex': instance.sex,
      'education': instance.education,
      'nationality': instance.nationality,
      'phone': instance.phone,
      'relatives': instance.relatives,
      'birth_place': instance.birthPlace,
      'current_place': instance.currentPlace,
      'positions': instance.positions,
      'last_med': instance.lastMed,
      'comment': instance.comment,
    };

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      afghan: json['afghan'] as String? ?? "",
      invalid: json['invalid'] as String? ?? "",
      chernobyl: json['chernobyl'] as String? ?? "",
      railwayTitle: json['railway_title'] as String? ?? "",
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'afghan': instance.afghan,
      'invalid': instance.invalid,
      'chernobyl': instance.chernobyl,
      'railway_title': instance.railwayTitle,
    };

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      id: (json['id'] as num).toInt(),
      organization:
          Organization.fromJson(json['organization'] as Map<String, dynamic>),
      position: json['position'] as String,
      positionType: json['position_type'] as String,
      positionExtension: json['position_extension'],
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'id': instance.id,
      'organization': instance.organization,
      'position': instance.position,
      'position_type': instance.positionType,
      'position_extension': instance.positionExtension,
    };

Organization _$OrganizationFromJson(Map<String, dynamic> json) => Organization(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      inn: (json['inn'] as num).toInt(),
    );

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'inn': instance.inn,
    };

Relative _$RelativeFromJson(Map<String, dynamic> json) => Relative(
      id: (json['id'] as num).toInt(),
      relative: json['relative'] as String,
      fullName: json['full_name'] as String,
      birthPlace: json['birth_place'] as String,
      post: json['post'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$RelativeToJson(Relative instance) => <String, dynamic>{
      'id': instance.id,
      'relative': instance.relative,
      'full_name': instance.fullName,
      'birth_place': instance.birthPlace,
      'post': instance.post,
      'address': instance.address,
    };
