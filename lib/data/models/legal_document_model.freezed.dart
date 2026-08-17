// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'legal_document_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LegalSectionModel {

 String get heading; String get body;
/// Create a copy of LegalSectionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegalSectionModelCopyWith<LegalSectionModel> get copyWith => _$LegalSectionModelCopyWithImpl<LegalSectionModel>(this as LegalSectionModel, _$identity);

  /// Serializes this LegalSectionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegalSectionModel&&(identical(other.heading, heading) || other.heading == heading)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,heading,body);

@override
String toString() {
  return 'LegalSectionModel(heading: $heading, body: $body)';
}


}

/// @nodoc
abstract mixin class $LegalSectionModelCopyWith<$Res>  {
  factory $LegalSectionModelCopyWith(LegalSectionModel value, $Res Function(LegalSectionModel) _then) = _$LegalSectionModelCopyWithImpl;
@useResult
$Res call({
 String heading, String body
});




}
/// @nodoc
class _$LegalSectionModelCopyWithImpl<$Res>
    implements $LegalSectionModelCopyWith<$Res> {
  _$LegalSectionModelCopyWithImpl(this._self, this._then);

  final LegalSectionModel _self;
  final $Res Function(LegalSectionModel) _then;

/// Create a copy of LegalSectionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? heading = null,Object? body = null,}) {
  return _then(_self.copyWith(
heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LegalSectionModel].
extension LegalSectionModelPatterns on LegalSectionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LegalSectionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LegalSectionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LegalSectionModel value)  $default,){
final _that = this;
switch (_that) {
case _LegalSectionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LegalSectionModel value)?  $default,){
final _that = this;
switch (_that) {
case _LegalSectionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String heading,  String body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LegalSectionModel() when $default != null:
return $default(_that.heading,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String heading,  String body)  $default,) {final _that = this;
switch (_that) {
case _LegalSectionModel():
return $default(_that.heading,_that.body);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String heading,  String body)?  $default,) {final _that = this;
switch (_that) {
case _LegalSectionModel() when $default != null:
return $default(_that.heading,_that.body);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LegalSectionModel extends LegalSectionModel {
  const _LegalSectionModel({required this.heading, required this.body}): super._();
  factory _LegalSectionModel.fromJson(Map<String, dynamic> json) => _$LegalSectionModelFromJson(json);

@override final  String heading;
@override final  String body;

/// Create a copy of LegalSectionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegalSectionModelCopyWith<_LegalSectionModel> get copyWith => __$LegalSectionModelCopyWithImpl<_LegalSectionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LegalSectionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegalSectionModel&&(identical(other.heading, heading) || other.heading == heading)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,heading,body);

@override
String toString() {
  return 'LegalSectionModel(heading: $heading, body: $body)';
}


}

/// @nodoc
abstract mixin class _$LegalSectionModelCopyWith<$Res> implements $LegalSectionModelCopyWith<$Res> {
  factory _$LegalSectionModelCopyWith(_LegalSectionModel value, $Res Function(_LegalSectionModel) _then) = __$LegalSectionModelCopyWithImpl;
@override @useResult
$Res call({
 String heading, String body
});




}
/// @nodoc
class __$LegalSectionModelCopyWithImpl<$Res>
    implements _$LegalSectionModelCopyWith<$Res> {
  __$LegalSectionModelCopyWithImpl(this._self, this._then);

  final _LegalSectionModel _self;
  final $Res Function(_LegalSectionModel) _then;

/// Create a copy of LegalSectionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? heading = null,Object? body = null,}) {
  return _then(_LegalSectionModel(
heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LegalDocumentModel {

 String get type; String get title; String get version; String get effectiveDate; List<LegalSectionModel> get sections;
/// Create a copy of LegalDocumentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegalDocumentModelCopyWith<LegalDocumentModel> get copyWith => _$LegalDocumentModelCopyWithImpl<LegalDocumentModel>(this as LegalDocumentModel, _$identity);

  /// Serializes this LegalDocumentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegalDocumentModel&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.version, version) || other.version == version)&&(identical(other.effectiveDate, effectiveDate) || other.effectiveDate == effectiveDate)&&const DeepCollectionEquality().equals(other.sections, sections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,version,effectiveDate,const DeepCollectionEquality().hash(sections));

@override
String toString() {
  return 'LegalDocumentModel(type: $type, title: $title, version: $version, effectiveDate: $effectiveDate, sections: $sections)';
}


}

/// @nodoc
abstract mixin class $LegalDocumentModelCopyWith<$Res>  {
  factory $LegalDocumentModelCopyWith(LegalDocumentModel value, $Res Function(LegalDocumentModel) _then) = _$LegalDocumentModelCopyWithImpl;
@useResult
$Res call({
 String type, String title, String version, String effectiveDate, List<LegalSectionModel> sections
});




}
/// @nodoc
class _$LegalDocumentModelCopyWithImpl<$Res>
    implements $LegalDocumentModelCopyWith<$Res> {
  _$LegalDocumentModelCopyWithImpl(this._self, this._then);

  final LegalDocumentModel _self;
  final $Res Function(LegalDocumentModel) _then;

/// Create a copy of LegalDocumentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? title = null,Object? version = null,Object? effectiveDate = null,Object? sections = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,effectiveDate: null == effectiveDate ? _self.effectiveDate : effectiveDate // ignore: cast_nullable_to_non_nullable
as String,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<LegalSectionModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [LegalDocumentModel].
extension LegalDocumentModelPatterns on LegalDocumentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LegalDocumentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LegalDocumentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LegalDocumentModel value)  $default,){
final _that = this;
switch (_that) {
case _LegalDocumentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LegalDocumentModel value)?  $default,){
final _that = this;
switch (_that) {
case _LegalDocumentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String title,  String version,  String effectiveDate,  List<LegalSectionModel> sections)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LegalDocumentModel() when $default != null:
return $default(_that.type,_that.title,_that.version,_that.effectiveDate,_that.sections);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String title,  String version,  String effectiveDate,  List<LegalSectionModel> sections)  $default,) {final _that = this;
switch (_that) {
case _LegalDocumentModel():
return $default(_that.type,_that.title,_that.version,_that.effectiveDate,_that.sections);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String title,  String version,  String effectiveDate,  List<LegalSectionModel> sections)?  $default,) {final _that = this;
switch (_that) {
case _LegalDocumentModel() when $default != null:
return $default(_that.type,_that.title,_that.version,_that.effectiveDate,_that.sections);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LegalDocumentModel extends LegalDocumentModel {
  const _LegalDocumentModel({required this.type, required this.title, required this.version, required this.effectiveDate, final  List<LegalSectionModel> sections = const <LegalSectionModel>[]}): _sections = sections,super._();
  factory _LegalDocumentModel.fromJson(Map<String, dynamic> json) => _$LegalDocumentModelFromJson(json);

@override final  String type;
@override final  String title;
@override final  String version;
@override final  String effectiveDate;
 final  List<LegalSectionModel> _sections;
@override@JsonKey() List<LegalSectionModel> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}


/// Create a copy of LegalDocumentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegalDocumentModelCopyWith<_LegalDocumentModel> get copyWith => __$LegalDocumentModelCopyWithImpl<_LegalDocumentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LegalDocumentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegalDocumentModel&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.version, version) || other.version == version)&&(identical(other.effectiveDate, effectiveDate) || other.effectiveDate == effectiveDate)&&const DeepCollectionEquality().equals(other._sections, _sections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,version,effectiveDate,const DeepCollectionEquality().hash(_sections));

@override
String toString() {
  return 'LegalDocumentModel(type: $type, title: $title, version: $version, effectiveDate: $effectiveDate, sections: $sections)';
}


}

/// @nodoc
abstract mixin class _$LegalDocumentModelCopyWith<$Res> implements $LegalDocumentModelCopyWith<$Res> {
  factory _$LegalDocumentModelCopyWith(_LegalDocumentModel value, $Res Function(_LegalDocumentModel) _then) = __$LegalDocumentModelCopyWithImpl;
@override @useResult
$Res call({
 String type, String title, String version, String effectiveDate, List<LegalSectionModel> sections
});




}
/// @nodoc
class __$LegalDocumentModelCopyWithImpl<$Res>
    implements _$LegalDocumentModelCopyWith<$Res> {
  __$LegalDocumentModelCopyWithImpl(this._self, this._then);

  final _LegalDocumentModel _self;
  final $Res Function(_LegalDocumentModel) _then;

/// Create a copy of LegalDocumentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? title = null,Object? version = null,Object? effectiveDate = null,Object? sections = null,}) {
  return _then(_LegalDocumentModel(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,effectiveDate: null == effectiveDate ? _self.effectiveDate : effectiveDate // ignore: cast_nullable_to_non_nullable
as String,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<LegalSectionModel>,
  ));
}


}

// dart format on
