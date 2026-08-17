// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UsageSummaryModel {

 String get date; int get baseQuestionUsed; int get limit; int get remaining;
/// Create a copy of UsageSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsageSummaryModelCopyWith<UsageSummaryModel> get copyWith => _$UsageSummaryModelCopyWithImpl<UsageSummaryModel>(this as UsageSummaryModel, _$identity);

  /// Serializes this UsageSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsageSummaryModel&&(identical(other.date, date) || other.date == date)&&(identical(other.baseQuestionUsed, baseQuestionUsed) || other.baseQuestionUsed == baseQuestionUsed)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.remaining, remaining) || other.remaining == remaining));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,baseQuestionUsed,limit,remaining);

@override
String toString() {
  return 'UsageSummaryModel(date: $date, baseQuestionUsed: $baseQuestionUsed, limit: $limit, remaining: $remaining)';
}


}

/// @nodoc
abstract mixin class $UsageSummaryModelCopyWith<$Res>  {
  factory $UsageSummaryModelCopyWith(UsageSummaryModel value, $Res Function(UsageSummaryModel) _then) = _$UsageSummaryModelCopyWithImpl;
@useResult
$Res call({
 String date, int baseQuestionUsed, int limit, int remaining
});




}
/// @nodoc
class _$UsageSummaryModelCopyWithImpl<$Res>
    implements $UsageSummaryModelCopyWith<$Res> {
  _$UsageSummaryModelCopyWithImpl(this._self, this._then);

  final UsageSummaryModel _self;
  final $Res Function(UsageSummaryModel) _then;

/// Create a copy of UsageSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? baseQuestionUsed = null,Object? limit = null,Object? remaining = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,baseQuestionUsed: null == baseQuestionUsed ? _self.baseQuestionUsed : baseQuestionUsed // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UsageSummaryModel].
extension UsageSummaryModelPatterns on UsageSummaryModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UsageSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UsageSummaryModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UsageSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _UsageSummaryModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UsageSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _UsageSummaryModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  int baseQuestionUsed,  int limit,  int remaining)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UsageSummaryModel() when $default != null:
return $default(_that.date,_that.baseQuestionUsed,_that.limit,_that.remaining);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  int baseQuestionUsed,  int limit,  int remaining)  $default,) {final _that = this;
switch (_that) {
case _UsageSummaryModel():
return $default(_that.date,_that.baseQuestionUsed,_that.limit,_that.remaining);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  int baseQuestionUsed,  int limit,  int remaining)?  $default,) {final _that = this;
switch (_that) {
case _UsageSummaryModel() when $default != null:
return $default(_that.date,_that.baseQuestionUsed,_that.limit,_that.remaining);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UsageSummaryModel extends UsageSummaryModel {
  const _UsageSummaryModel({required this.date, required this.baseQuestionUsed, required this.limit, required this.remaining}): super._();
  factory _UsageSummaryModel.fromJson(Map<String, dynamic> json) => _$UsageSummaryModelFromJson(json);

@override final  String date;
@override final  int baseQuestionUsed;
@override final  int limit;
@override final  int remaining;

/// Create a copy of UsageSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsageSummaryModelCopyWith<_UsageSummaryModel> get copyWith => __$UsageSummaryModelCopyWithImpl<_UsageSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UsageSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UsageSummaryModel&&(identical(other.date, date) || other.date == date)&&(identical(other.baseQuestionUsed, baseQuestionUsed) || other.baseQuestionUsed == baseQuestionUsed)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.remaining, remaining) || other.remaining == remaining));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,baseQuestionUsed,limit,remaining);

@override
String toString() {
  return 'UsageSummaryModel(date: $date, baseQuestionUsed: $baseQuestionUsed, limit: $limit, remaining: $remaining)';
}


}

/// @nodoc
abstract mixin class _$UsageSummaryModelCopyWith<$Res> implements $UsageSummaryModelCopyWith<$Res> {
  factory _$UsageSummaryModelCopyWith(_UsageSummaryModel value, $Res Function(_UsageSummaryModel) _then) = __$UsageSummaryModelCopyWithImpl;
@override @useResult
$Res call({
 String date, int baseQuestionUsed, int limit, int remaining
});




}
/// @nodoc
class __$UsageSummaryModelCopyWithImpl<$Res>
    implements _$UsageSummaryModelCopyWith<$Res> {
  __$UsageSummaryModelCopyWithImpl(this._self, this._then);

  final _UsageSummaryModel _self;
  final $Res Function(_UsageSummaryModel) _then;

/// Create a copy of UsageSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? baseQuestionUsed = null,Object? limit = null,Object? remaining = null,}) {
  return _then(_UsageSummaryModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,baseQuestionUsed: null == baseQuestionUsed ? _self.baseQuestionUsed : baseQuestionUsed // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$UserProfileModel {

 String get id; String get nickname; String? get email; bool get isPro; UsageSummaryModel get usage;
/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileModelCopyWith<UserProfileModel> get copyWith => _$UserProfileModelCopyWithImpl<UserProfileModel>(this as UserProfileModel, _$identity);

  /// Serializes this UserProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.email, email) || other.email == email)&&(identical(other.isPro, isPro) || other.isPro == isPro)&&(identical(other.usage, usage) || other.usage == usage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nickname,email,isPro,usage);

@override
String toString() {
  return 'UserProfileModel(id: $id, nickname: $nickname, email: $email, isPro: $isPro, usage: $usage)';
}


}

/// @nodoc
abstract mixin class $UserProfileModelCopyWith<$Res>  {
  factory $UserProfileModelCopyWith(UserProfileModel value, $Res Function(UserProfileModel) _then) = _$UserProfileModelCopyWithImpl;
@useResult
$Res call({
 String id, String nickname, String? email, bool isPro, UsageSummaryModel usage
});


$UsageSummaryModelCopyWith<$Res> get usage;

}
/// @nodoc
class _$UserProfileModelCopyWithImpl<$Res>
    implements $UserProfileModelCopyWith<$Res> {
  _$UserProfileModelCopyWithImpl(this._self, this._then);

  final UserProfileModel _self;
  final $Res Function(UserProfileModel) _then;

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nickname = null,Object? email = freezed,Object? isPro = null,Object? usage = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isPro: null == isPro ? _self.isPro : isPro // ignore: cast_nullable_to_non_nullable
as bool,usage: null == usage ? _self.usage : usage // ignore: cast_nullable_to_non_nullable
as UsageSummaryModel,
  ));
}
/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UsageSummaryModelCopyWith<$Res> get usage {
  
  return $UsageSummaryModelCopyWith<$Res>(_self.usage, (value) {
    return _then(_self.copyWith(usage: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserProfileModel].
extension UserProfileModelPatterns on UserProfileModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nickname,  String? email,  bool isPro,  UsageSummaryModel usage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
return $default(_that.id,_that.nickname,_that.email,_that.isPro,_that.usage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nickname,  String? email,  bool isPro,  UsageSummaryModel usage)  $default,) {final _that = this;
switch (_that) {
case _UserProfileModel():
return $default(_that.id,_that.nickname,_that.email,_that.isPro,_that.usage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nickname,  String? email,  bool isPro,  UsageSummaryModel usage)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
return $default(_that.id,_that.nickname,_that.email,_that.isPro,_that.usage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileModel extends UserProfileModel {
  const _UserProfileModel({required this.id, required this.nickname, this.email, this.isPro = false, required this.usage}): super._();
  factory _UserProfileModel.fromJson(Map<String, dynamic> json) => _$UserProfileModelFromJson(json);

@override final  String id;
@override final  String nickname;
@override final  String? email;
@override@JsonKey() final  bool isPro;
@override final  UsageSummaryModel usage;

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileModelCopyWith<_UserProfileModel> get copyWith => __$UserProfileModelCopyWithImpl<_UserProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.email, email) || other.email == email)&&(identical(other.isPro, isPro) || other.isPro == isPro)&&(identical(other.usage, usage) || other.usage == usage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nickname,email,isPro,usage);

@override
String toString() {
  return 'UserProfileModel(id: $id, nickname: $nickname, email: $email, isPro: $isPro, usage: $usage)';
}


}

/// @nodoc
abstract mixin class _$UserProfileModelCopyWith<$Res> implements $UserProfileModelCopyWith<$Res> {
  factory _$UserProfileModelCopyWith(_UserProfileModel value, $Res Function(_UserProfileModel) _then) = __$UserProfileModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String nickname, String? email, bool isPro, UsageSummaryModel usage
});


@override $UsageSummaryModelCopyWith<$Res> get usage;

}
/// @nodoc
class __$UserProfileModelCopyWithImpl<$Res>
    implements _$UserProfileModelCopyWith<$Res> {
  __$UserProfileModelCopyWithImpl(this._self, this._then);

  final _UserProfileModel _self;
  final $Res Function(_UserProfileModel) _then;

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nickname = null,Object? email = freezed,Object? isPro = null,Object? usage = null,}) {
  return _then(_UserProfileModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isPro: null == isPro ? _self.isPro : isPro // ignore: cast_nullable_to_non_nullable
as bool,usage: null == usage ? _self.usage : usage // ignore: cast_nullable_to_non_nullable
as UsageSummaryModel,
  ));
}

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UsageSummaryModelCopyWith<$Res> get usage {
  
  return $UsageSummaryModelCopyWith<$Res>(_self.usage, (value) {
    return _then(_self.copyWith(usage: value));
  });
}
}

// dart format on
