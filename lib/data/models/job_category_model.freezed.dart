// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobRoleModel {

 String get id; String get name;
/// Create a copy of JobRoleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobRoleModelCopyWith<JobRoleModel> get copyWith => _$JobRoleModelCopyWithImpl<JobRoleModel>(this as JobRoleModel, _$identity);

  /// Serializes this JobRoleModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobRoleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'JobRoleModel(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $JobRoleModelCopyWith<$Res>  {
  factory $JobRoleModelCopyWith(JobRoleModel value, $Res Function(JobRoleModel) _then) = _$JobRoleModelCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$JobRoleModelCopyWithImpl<$Res>
    implements $JobRoleModelCopyWith<$Res> {
  _$JobRoleModelCopyWithImpl(this._self, this._then);

  final JobRoleModel _self;
  final $Res Function(JobRoleModel) _then;

/// Create a copy of JobRoleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JobRoleModel].
extension JobRoleModelPatterns on JobRoleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobRoleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobRoleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobRoleModel value)  $default,){
final _that = this;
switch (_that) {
case _JobRoleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobRoleModel value)?  $default,){
final _that = this;
switch (_that) {
case _JobRoleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobRoleModel() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _JobRoleModel():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _JobRoleModel() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobRoleModel extends JobRoleModel {
  const _JobRoleModel({required this.id, required this.name}): super._();
  factory _JobRoleModel.fromJson(Map<String, dynamic> json) => _$JobRoleModelFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of JobRoleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobRoleModelCopyWith<_JobRoleModel> get copyWith => __$JobRoleModelCopyWithImpl<_JobRoleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobRoleModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobRoleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'JobRoleModel(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$JobRoleModelCopyWith<$Res> implements $JobRoleModelCopyWith<$Res> {
  factory _$JobRoleModelCopyWith(_JobRoleModel value, $Res Function(_JobRoleModel) _then) = __$JobRoleModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$JobRoleModelCopyWithImpl<$Res>
    implements _$JobRoleModelCopyWith<$Res> {
  __$JobRoleModelCopyWithImpl(this._self, this._then);

  final _JobRoleModel _self;
  final $Res Function(_JobRoleModel) _then;

/// Create a copy of JobRoleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_JobRoleModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$JobCategoryModel {

 String get id; String get name; List<JobRoleModel> get roles;
/// Create a copy of JobCategoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobCategoryModelCopyWith<JobCategoryModel> get copyWith => _$JobCategoryModelCopyWithImpl<JobCategoryModel>(this as JobCategoryModel, _$identity);

  /// Serializes this JobCategoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobCategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.roles, roles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(roles));

@override
String toString() {
  return 'JobCategoryModel(id: $id, name: $name, roles: $roles)';
}


}

/// @nodoc
abstract mixin class $JobCategoryModelCopyWith<$Res>  {
  factory $JobCategoryModelCopyWith(JobCategoryModel value, $Res Function(JobCategoryModel) _then) = _$JobCategoryModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<JobRoleModel> roles
});




}
/// @nodoc
class _$JobCategoryModelCopyWithImpl<$Res>
    implements $JobCategoryModelCopyWith<$Res> {
  _$JobCategoryModelCopyWithImpl(this._self, this._then);

  final JobCategoryModel _self;
  final $Res Function(JobCategoryModel) _then;

/// Create a copy of JobCategoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? roles = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<JobRoleModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [JobCategoryModel].
extension JobCategoryModelPatterns on JobCategoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobCategoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobCategoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobCategoryModel value)  $default,){
final _that = this;
switch (_that) {
case _JobCategoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobCategoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _JobCategoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<JobRoleModel> roles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobCategoryModel() when $default != null:
return $default(_that.id,_that.name,_that.roles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<JobRoleModel> roles)  $default,) {final _that = this;
switch (_that) {
case _JobCategoryModel():
return $default(_that.id,_that.name,_that.roles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<JobRoleModel> roles)?  $default,) {final _that = this;
switch (_that) {
case _JobCategoryModel() when $default != null:
return $default(_that.id,_that.name,_that.roles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobCategoryModel extends JobCategoryModel {
  const _JobCategoryModel({required this.id, required this.name, final  List<JobRoleModel> roles = const <JobRoleModel>[]}): _roles = roles,super._();
  factory _JobCategoryModel.fromJson(Map<String, dynamic> json) => _$JobCategoryModelFromJson(json);

@override final  String id;
@override final  String name;
 final  List<JobRoleModel> _roles;
@override@JsonKey() List<JobRoleModel> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}


/// Create a copy of JobCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobCategoryModelCopyWith<_JobCategoryModel> get copyWith => __$JobCategoryModelCopyWithImpl<_JobCategoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobCategoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobCategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._roles, _roles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_roles));

@override
String toString() {
  return 'JobCategoryModel(id: $id, name: $name, roles: $roles)';
}


}

/// @nodoc
abstract mixin class _$JobCategoryModelCopyWith<$Res> implements $JobCategoryModelCopyWith<$Res> {
  factory _$JobCategoryModelCopyWith(_JobCategoryModel value, $Res Function(_JobCategoryModel) _then) = __$JobCategoryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<JobRoleModel> roles
});




}
/// @nodoc
class __$JobCategoryModelCopyWithImpl<$Res>
    implements _$JobCategoryModelCopyWith<$Res> {
  __$JobCategoryModelCopyWithImpl(this._self, this._then);

  final _JobCategoryModel _self;
  final $Res Function(_JobCategoryModel) _then;

/// Create a copy of JobCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? roles = null,}) {
  return _then(_JobCategoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<JobRoleModel>,
  ));
}


}

// dart format on
