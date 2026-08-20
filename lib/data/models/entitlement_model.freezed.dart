// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entitlement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EntitlementModel {

 String get plan; bool get isPro; bool get autoRenewing; int get freeInterviewsUsed; int get freeInterviewsRemaining; String? get expiresAt;
/// Create a copy of EntitlementModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntitlementModelCopyWith<EntitlementModel> get copyWith => _$EntitlementModelCopyWithImpl<EntitlementModel>(this as EntitlementModel, _$identity);

  /// Serializes this EntitlementModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntitlementModel&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.isPro, isPro) || other.isPro == isPro)&&(identical(other.autoRenewing, autoRenewing) || other.autoRenewing == autoRenewing)&&(identical(other.freeInterviewsUsed, freeInterviewsUsed) || other.freeInterviewsUsed == freeInterviewsUsed)&&(identical(other.freeInterviewsRemaining, freeInterviewsRemaining) || other.freeInterviewsRemaining == freeInterviewsRemaining)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plan,isPro,autoRenewing,freeInterviewsUsed,freeInterviewsRemaining,expiresAt);

@override
String toString() {
  return 'EntitlementModel(plan: $plan, isPro: $isPro, autoRenewing: $autoRenewing, freeInterviewsUsed: $freeInterviewsUsed, freeInterviewsRemaining: $freeInterviewsRemaining, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $EntitlementModelCopyWith<$Res>  {
  factory $EntitlementModelCopyWith(EntitlementModel value, $Res Function(EntitlementModel) _then) = _$EntitlementModelCopyWithImpl;
@useResult
$Res call({
 String plan, bool isPro, bool autoRenewing, int freeInterviewsUsed, int freeInterviewsRemaining, String? expiresAt
});




}
/// @nodoc
class _$EntitlementModelCopyWithImpl<$Res>
    implements $EntitlementModelCopyWith<$Res> {
  _$EntitlementModelCopyWithImpl(this._self, this._then);

  final EntitlementModel _self;
  final $Res Function(EntitlementModel) _then;

/// Create a copy of EntitlementModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? plan = null,Object? isPro = null,Object? autoRenewing = null,Object? freeInterviewsUsed = null,Object? freeInterviewsRemaining = null,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,isPro: null == isPro ? _self.isPro : isPro // ignore: cast_nullable_to_non_nullable
as bool,autoRenewing: null == autoRenewing ? _self.autoRenewing : autoRenewing // ignore: cast_nullable_to_non_nullable
as bool,freeInterviewsUsed: null == freeInterviewsUsed ? _self.freeInterviewsUsed : freeInterviewsUsed // ignore: cast_nullable_to_non_nullable
as int,freeInterviewsRemaining: null == freeInterviewsRemaining ? _self.freeInterviewsRemaining : freeInterviewsRemaining // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EntitlementModel].
extension EntitlementModelPatterns on EntitlementModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntitlementModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntitlementModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntitlementModel value)  $default,){
final _that = this;
switch (_that) {
case _EntitlementModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntitlementModel value)?  $default,){
final _that = this;
switch (_that) {
case _EntitlementModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String plan,  bool isPro,  bool autoRenewing,  int freeInterviewsUsed,  int freeInterviewsRemaining,  String? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntitlementModel() when $default != null:
return $default(_that.plan,_that.isPro,_that.autoRenewing,_that.freeInterviewsUsed,_that.freeInterviewsRemaining,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String plan,  bool isPro,  bool autoRenewing,  int freeInterviewsUsed,  int freeInterviewsRemaining,  String? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _EntitlementModel():
return $default(_that.plan,_that.isPro,_that.autoRenewing,_that.freeInterviewsUsed,_that.freeInterviewsRemaining,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String plan,  bool isPro,  bool autoRenewing,  int freeInterviewsUsed,  int freeInterviewsRemaining,  String? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _EntitlementModel() when $default != null:
return $default(_that.plan,_that.isPro,_that.autoRenewing,_that.freeInterviewsUsed,_that.freeInterviewsRemaining,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EntitlementModel extends EntitlementModel {
  const _EntitlementModel({required this.plan, required this.isPro, required this.autoRenewing, required this.freeInterviewsUsed, required this.freeInterviewsRemaining, this.expiresAt}): super._();
  factory _EntitlementModel.fromJson(Map<String, dynamic> json) => _$EntitlementModelFromJson(json);

@override final  String plan;
@override final  bool isPro;
@override final  bool autoRenewing;
@override final  int freeInterviewsUsed;
@override final  int freeInterviewsRemaining;
@override final  String? expiresAt;

/// Create a copy of EntitlementModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntitlementModelCopyWith<_EntitlementModel> get copyWith => __$EntitlementModelCopyWithImpl<_EntitlementModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EntitlementModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntitlementModel&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.isPro, isPro) || other.isPro == isPro)&&(identical(other.autoRenewing, autoRenewing) || other.autoRenewing == autoRenewing)&&(identical(other.freeInterviewsUsed, freeInterviewsUsed) || other.freeInterviewsUsed == freeInterviewsUsed)&&(identical(other.freeInterviewsRemaining, freeInterviewsRemaining) || other.freeInterviewsRemaining == freeInterviewsRemaining)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plan,isPro,autoRenewing,freeInterviewsUsed,freeInterviewsRemaining,expiresAt);

@override
String toString() {
  return 'EntitlementModel(plan: $plan, isPro: $isPro, autoRenewing: $autoRenewing, freeInterviewsUsed: $freeInterviewsUsed, freeInterviewsRemaining: $freeInterviewsRemaining, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$EntitlementModelCopyWith<$Res> implements $EntitlementModelCopyWith<$Res> {
  factory _$EntitlementModelCopyWith(_EntitlementModel value, $Res Function(_EntitlementModel) _then) = __$EntitlementModelCopyWithImpl;
@override @useResult
$Res call({
 String plan, bool isPro, bool autoRenewing, int freeInterviewsUsed, int freeInterviewsRemaining, String? expiresAt
});




}
/// @nodoc
class __$EntitlementModelCopyWithImpl<$Res>
    implements _$EntitlementModelCopyWith<$Res> {
  __$EntitlementModelCopyWithImpl(this._self, this._then);

  final _EntitlementModel _self;
  final $Res Function(_EntitlementModel) _then;

/// Create a copy of EntitlementModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = null,Object? isPro = null,Object? autoRenewing = null,Object? freeInterviewsUsed = null,Object? freeInterviewsRemaining = null,Object? expiresAt = freezed,}) {
  return _then(_EntitlementModel(
plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,isPro: null == isPro ? _self.isPro : isPro // ignore: cast_nullable_to_non_nullable
as bool,autoRenewing: null == autoRenewing ? _self.autoRenewing : autoRenewing // ignore: cast_nullable_to_non_nullable
as bool,freeInterviewsUsed: null == freeInterviewsUsed ? _self.freeInterviewsUsed : freeInterviewsUsed // ignore: cast_nullable_to_non_nullable
as int,freeInterviewsRemaining: null == freeInterviewsRemaining ? _self.freeInterviewsRemaining : freeInterviewsRemaining // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
