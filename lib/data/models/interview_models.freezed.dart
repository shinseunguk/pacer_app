// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interview_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProgressModel {

 int get current; int get total;
/// Create a copy of ProgressModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressModelCopyWith<ProgressModel> get copyWith => _$ProgressModelCopyWithImpl<ProgressModel>(this as ProgressModel, _$identity);

  /// Serializes this ProgressModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressModel&&(identical(other.current, current) || other.current == current)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,current,total);

@override
String toString() {
  return 'ProgressModel(current: $current, total: $total)';
}


}

/// @nodoc
abstract mixin class $ProgressModelCopyWith<$Res>  {
  factory $ProgressModelCopyWith(ProgressModel value, $Res Function(ProgressModel) _then) = _$ProgressModelCopyWithImpl;
@useResult
$Res call({
 int current, int total
});




}
/// @nodoc
class _$ProgressModelCopyWithImpl<$Res>
    implements $ProgressModelCopyWith<$Res> {
  _$ProgressModelCopyWithImpl(this._self, this._then);

  final ProgressModel _self;
  final $Res Function(ProgressModel) _then;

/// Create a copy of ProgressModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? current = null,Object? total = null,}) {
  return _then(_self.copyWith(
current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProgressModel].
extension ProgressModelPatterns on ProgressModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProgressModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProgressModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProgressModel value)  $default,){
final _that = this;
switch (_that) {
case _ProgressModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProgressModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProgressModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int current,  int total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgressModel() when $default != null:
return $default(_that.current,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int current,  int total)  $default,) {final _that = this;
switch (_that) {
case _ProgressModel():
return $default(_that.current,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int current,  int total)?  $default,) {final _that = this;
switch (_that) {
case _ProgressModel() when $default != null:
return $default(_that.current,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProgressModel extends ProgressModel {
  const _ProgressModel({this.current = 0, this.total = 0}): super._();
  factory _ProgressModel.fromJson(Map<String, dynamic> json) => _$ProgressModelFromJson(json);

@override@JsonKey() final  int current;
@override@JsonKey() final  int total;

/// Create a copy of ProgressModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressModelCopyWith<_ProgressModel> get copyWith => __$ProgressModelCopyWithImpl<_ProgressModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgressModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressModel&&(identical(other.current, current) || other.current == current)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,current,total);

@override
String toString() {
  return 'ProgressModel(current: $current, total: $total)';
}


}

/// @nodoc
abstract mixin class _$ProgressModelCopyWith<$Res> implements $ProgressModelCopyWith<$Res> {
  factory _$ProgressModelCopyWith(_ProgressModel value, $Res Function(_ProgressModel) _then) = __$ProgressModelCopyWithImpl;
@override @useResult
$Res call({
 int current, int total
});




}
/// @nodoc
class __$ProgressModelCopyWithImpl<$Res>
    implements _$ProgressModelCopyWith<$Res> {
  __$ProgressModelCopyWithImpl(this._self, this._then);

  final _ProgressModel _self;
  final $Res Function(_ProgressModel) _then;

/// Create a copy of ProgressModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? current = null,Object? total = null,}) {
  return _then(_ProgressModel(
current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MessageFeedbackModel {

 String? get feedback; String? get modelAnswer;
/// Create a copy of MessageFeedbackModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageFeedbackModelCopyWith<MessageFeedbackModel> get copyWith => _$MessageFeedbackModelCopyWithImpl<MessageFeedbackModel>(this as MessageFeedbackModel, _$identity);

  /// Serializes this MessageFeedbackModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageFeedbackModel&&(identical(other.feedback, feedback) || other.feedback == feedback)&&(identical(other.modelAnswer, modelAnswer) || other.modelAnswer == modelAnswer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,feedback,modelAnswer);

@override
String toString() {
  return 'MessageFeedbackModel(feedback: $feedback, modelAnswer: $modelAnswer)';
}


}

/// @nodoc
abstract mixin class $MessageFeedbackModelCopyWith<$Res>  {
  factory $MessageFeedbackModelCopyWith(MessageFeedbackModel value, $Res Function(MessageFeedbackModel) _then) = _$MessageFeedbackModelCopyWithImpl;
@useResult
$Res call({
 String? feedback, String? modelAnswer
});




}
/// @nodoc
class _$MessageFeedbackModelCopyWithImpl<$Res>
    implements $MessageFeedbackModelCopyWith<$Res> {
  _$MessageFeedbackModelCopyWithImpl(this._self, this._then);

  final MessageFeedbackModel _self;
  final $Res Function(MessageFeedbackModel) _then;

/// Create a copy of MessageFeedbackModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? feedback = freezed,Object? modelAnswer = freezed,}) {
  return _then(_self.copyWith(
feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,modelAnswer: freezed == modelAnswer ? _self.modelAnswer : modelAnswer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageFeedbackModel].
extension MessageFeedbackModelPatterns on MessageFeedbackModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageFeedbackModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageFeedbackModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageFeedbackModel value)  $default,){
final _that = this;
switch (_that) {
case _MessageFeedbackModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageFeedbackModel value)?  $default,){
final _that = this;
switch (_that) {
case _MessageFeedbackModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? feedback,  String? modelAnswer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageFeedbackModel() when $default != null:
return $default(_that.feedback,_that.modelAnswer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? feedback,  String? modelAnswer)  $default,) {final _that = this;
switch (_that) {
case _MessageFeedbackModel():
return $default(_that.feedback,_that.modelAnswer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? feedback,  String? modelAnswer)?  $default,) {final _that = this;
switch (_that) {
case _MessageFeedbackModel() when $default != null:
return $default(_that.feedback,_that.modelAnswer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageFeedbackModel extends MessageFeedbackModel {
  const _MessageFeedbackModel({this.feedback, this.modelAnswer}): super._();
  factory _MessageFeedbackModel.fromJson(Map<String, dynamic> json) => _$MessageFeedbackModelFromJson(json);

@override final  String? feedback;
@override final  String? modelAnswer;

/// Create a copy of MessageFeedbackModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageFeedbackModelCopyWith<_MessageFeedbackModel> get copyWith => __$MessageFeedbackModelCopyWithImpl<_MessageFeedbackModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageFeedbackModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageFeedbackModel&&(identical(other.feedback, feedback) || other.feedback == feedback)&&(identical(other.modelAnswer, modelAnswer) || other.modelAnswer == modelAnswer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,feedback,modelAnswer);

@override
String toString() {
  return 'MessageFeedbackModel(feedback: $feedback, modelAnswer: $modelAnswer)';
}


}

/// @nodoc
abstract mixin class _$MessageFeedbackModelCopyWith<$Res> implements $MessageFeedbackModelCopyWith<$Res> {
  factory _$MessageFeedbackModelCopyWith(_MessageFeedbackModel value, $Res Function(_MessageFeedbackModel) _then) = __$MessageFeedbackModelCopyWithImpl;
@override @useResult
$Res call({
 String? feedback, String? modelAnswer
});




}
/// @nodoc
class __$MessageFeedbackModelCopyWithImpl<$Res>
    implements _$MessageFeedbackModelCopyWith<$Res> {
  __$MessageFeedbackModelCopyWithImpl(this._self, this._then);

  final _MessageFeedbackModel _self;
  final $Res Function(_MessageFeedbackModel) _then;

/// Create a copy of MessageFeedbackModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? feedback = freezed,Object? modelAnswer = freezed,}) {
  return _then(_MessageFeedbackModel(
feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,modelAnswer: freezed == modelAnswer ? _self.modelAnswer : modelAnswer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$InterviewMessageModel {

 String get messageId; int get seq; String get type; String? get content; String? get parentId; MessageFeedbackModel? get feedback;
/// Create a copy of InterviewMessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterviewMessageModelCopyWith<InterviewMessageModel> get copyWith => _$InterviewMessageModelCopyWithImpl<InterviewMessageModel>(this as InterviewMessageModel, _$identity);

  /// Serializes this InterviewMessageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterviewMessageModel&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.feedback, feedback) || other.feedback == feedback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,seq,type,content,parentId,feedback);

@override
String toString() {
  return 'InterviewMessageModel(messageId: $messageId, seq: $seq, type: $type, content: $content, parentId: $parentId, feedback: $feedback)';
}


}

/// @nodoc
abstract mixin class $InterviewMessageModelCopyWith<$Res>  {
  factory $InterviewMessageModelCopyWith(InterviewMessageModel value, $Res Function(InterviewMessageModel) _then) = _$InterviewMessageModelCopyWithImpl;
@useResult
$Res call({
 String messageId, int seq, String type, String? content, String? parentId, MessageFeedbackModel? feedback
});


$MessageFeedbackModelCopyWith<$Res>? get feedback;

}
/// @nodoc
class _$InterviewMessageModelCopyWithImpl<$Res>
    implements $InterviewMessageModelCopyWith<$Res> {
  _$InterviewMessageModelCopyWithImpl(this._self, this._then);

  final InterviewMessageModel _self;
  final $Res Function(InterviewMessageModel) _then;

/// Create a copy of InterviewMessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageId = null,Object? seq = null,Object? type = null,Object? content = freezed,Object? parentId = freezed,Object? feedback = freezed,}) {
  return _then(_self.copyWith(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as MessageFeedbackModel?,
  ));
}
/// Create a copy of InterviewMessageModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageFeedbackModelCopyWith<$Res>? get feedback {
    if (_self.feedback == null) {
    return null;
  }

  return $MessageFeedbackModelCopyWith<$Res>(_self.feedback!, (value) {
    return _then(_self.copyWith(feedback: value));
  });
}
}


/// Adds pattern-matching-related methods to [InterviewMessageModel].
extension InterviewMessageModelPatterns on InterviewMessageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InterviewMessageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InterviewMessageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InterviewMessageModel value)  $default,){
final _that = this;
switch (_that) {
case _InterviewMessageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InterviewMessageModel value)?  $default,){
final _that = this;
switch (_that) {
case _InterviewMessageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String messageId,  int seq,  String type,  String? content,  String? parentId,  MessageFeedbackModel? feedback)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InterviewMessageModel() when $default != null:
return $default(_that.messageId,_that.seq,_that.type,_that.content,_that.parentId,_that.feedback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String messageId,  int seq,  String type,  String? content,  String? parentId,  MessageFeedbackModel? feedback)  $default,) {final _that = this;
switch (_that) {
case _InterviewMessageModel():
return $default(_that.messageId,_that.seq,_that.type,_that.content,_that.parentId,_that.feedback);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String messageId,  int seq,  String type,  String? content,  String? parentId,  MessageFeedbackModel? feedback)?  $default,) {final _that = this;
switch (_that) {
case _InterviewMessageModel() when $default != null:
return $default(_that.messageId,_that.seq,_that.type,_that.content,_that.parentId,_that.feedback);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InterviewMessageModel extends InterviewMessageModel {
  const _InterviewMessageModel({required this.messageId, required this.seq, required this.type, this.content, this.parentId, this.feedback}): super._();
  factory _InterviewMessageModel.fromJson(Map<String, dynamic> json) => _$InterviewMessageModelFromJson(json);

@override final  String messageId;
@override final  int seq;
@override final  String type;
@override final  String? content;
@override final  String? parentId;
@override final  MessageFeedbackModel? feedback;

/// Create a copy of InterviewMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterviewMessageModelCopyWith<_InterviewMessageModel> get copyWith => __$InterviewMessageModelCopyWithImpl<_InterviewMessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterviewMessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InterviewMessageModel&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.feedback, feedback) || other.feedback == feedback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,seq,type,content,parentId,feedback);

@override
String toString() {
  return 'InterviewMessageModel(messageId: $messageId, seq: $seq, type: $type, content: $content, parentId: $parentId, feedback: $feedback)';
}


}

/// @nodoc
abstract mixin class _$InterviewMessageModelCopyWith<$Res> implements $InterviewMessageModelCopyWith<$Res> {
  factory _$InterviewMessageModelCopyWith(_InterviewMessageModel value, $Res Function(_InterviewMessageModel) _then) = __$InterviewMessageModelCopyWithImpl;
@override @useResult
$Res call({
 String messageId, int seq, String type, String? content, String? parentId, MessageFeedbackModel? feedback
});


@override $MessageFeedbackModelCopyWith<$Res>? get feedback;

}
/// @nodoc
class __$InterviewMessageModelCopyWithImpl<$Res>
    implements _$InterviewMessageModelCopyWith<$Res> {
  __$InterviewMessageModelCopyWithImpl(this._self, this._then);

  final _InterviewMessageModel _self;
  final $Res Function(_InterviewMessageModel) _then;

/// Create a copy of InterviewMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? seq = null,Object? type = null,Object? content = freezed,Object? parentId = freezed,Object? feedback = freezed,}) {
  return _then(_InterviewMessageModel(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as MessageFeedbackModel?,
  ));
}

/// Create a copy of InterviewMessageModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageFeedbackModelCopyWith<$Res>? get feedback {
    if (_self.feedback == null) {
    return null;
  }

  return $MessageFeedbackModelCopyWith<$Res>(_self.feedback!, (value) {
    return _then(_self.copyWith(feedback: value));
  });
}
}


/// @nodoc
mixin _$CreatedInterviewModel {

 String get sessionId; String get status; ProgressModel get progress; InterviewMessageModel get firstQuestion;
/// Create a copy of CreatedInterviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatedInterviewModelCopyWith<CreatedInterviewModel> get copyWith => _$CreatedInterviewModelCopyWithImpl<CreatedInterviewModel>(this as CreatedInterviewModel, _$identity);

  /// Serializes this CreatedInterviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatedInterviewModel&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.firstQuestion, firstQuestion) || other.firstQuestion == firstQuestion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,status,progress,firstQuestion);

@override
String toString() {
  return 'CreatedInterviewModel(sessionId: $sessionId, status: $status, progress: $progress, firstQuestion: $firstQuestion)';
}


}

/// @nodoc
abstract mixin class $CreatedInterviewModelCopyWith<$Res>  {
  factory $CreatedInterviewModelCopyWith(CreatedInterviewModel value, $Res Function(CreatedInterviewModel) _then) = _$CreatedInterviewModelCopyWithImpl;
@useResult
$Res call({
 String sessionId, String status, ProgressModel progress, InterviewMessageModel firstQuestion
});


$ProgressModelCopyWith<$Res> get progress;$InterviewMessageModelCopyWith<$Res> get firstQuestion;

}
/// @nodoc
class _$CreatedInterviewModelCopyWithImpl<$Res>
    implements $CreatedInterviewModelCopyWith<$Res> {
  _$CreatedInterviewModelCopyWithImpl(this._self, this._then);

  final CreatedInterviewModel _self;
  final $Res Function(CreatedInterviewModel) _then;

/// Create a copy of CreatedInterviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? status = null,Object? progress = null,Object? firstQuestion = null,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as ProgressModel,firstQuestion: null == firstQuestion ? _self.firstQuestion : firstQuestion // ignore: cast_nullable_to_non_nullable
as InterviewMessageModel,
  ));
}
/// Create a copy of CreatedInterviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgressModelCopyWith<$Res> get progress {
  
  return $ProgressModelCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}/// Create a copy of CreatedInterviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InterviewMessageModelCopyWith<$Res> get firstQuestion {
  
  return $InterviewMessageModelCopyWith<$Res>(_self.firstQuestion, (value) {
    return _then(_self.copyWith(firstQuestion: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreatedInterviewModel].
extension CreatedInterviewModelPatterns on CreatedInterviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatedInterviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatedInterviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatedInterviewModel value)  $default,){
final _that = this;
switch (_that) {
case _CreatedInterviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatedInterviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _CreatedInterviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String status,  ProgressModel progress,  InterviewMessageModel firstQuestion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatedInterviewModel() when $default != null:
return $default(_that.sessionId,_that.status,_that.progress,_that.firstQuestion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String status,  ProgressModel progress,  InterviewMessageModel firstQuestion)  $default,) {final _that = this;
switch (_that) {
case _CreatedInterviewModel():
return $default(_that.sessionId,_that.status,_that.progress,_that.firstQuestion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String status,  ProgressModel progress,  InterviewMessageModel firstQuestion)?  $default,) {final _that = this;
switch (_that) {
case _CreatedInterviewModel() when $default != null:
return $default(_that.sessionId,_that.status,_that.progress,_that.firstQuestion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatedInterviewModel extends CreatedInterviewModel {
  const _CreatedInterviewModel({required this.sessionId, required this.status, required this.progress, required this.firstQuestion}): super._();
  factory _CreatedInterviewModel.fromJson(Map<String, dynamic> json) => _$CreatedInterviewModelFromJson(json);

@override final  String sessionId;
@override final  String status;
@override final  ProgressModel progress;
@override final  InterviewMessageModel firstQuestion;

/// Create a copy of CreatedInterviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatedInterviewModelCopyWith<_CreatedInterviewModel> get copyWith => __$CreatedInterviewModelCopyWithImpl<_CreatedInterviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatedInterviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatedInterviewModel&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.firstQuestion, firstQuestion) || other.firstQuestion == firstQuestion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,status,progress,firstQuestion);

@override
String toString() {
  return 'CreatedInterviewModel(sessionId: $sessionId, status: $status, progress: $progress, firstQuestion: $firstQuestion)';
}


}

/// @nodoc
abstract mixin class _$CreatedInterviewModelCopyWith<$Res> implements $CreatedInterviewModelCopyWith<$Res> {
  factory _$CreatedInterviewModelCopyWith(_CreatedInterviewModel value, $Res Function(_CreatedInterviewModel) _then) = __$CreatedInterviewModelCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String status, ProgressModel progress, InterviewMessageModel firstQuestion
});


@override $ProgressModelCopyWith<$Res> get progress;@override $InterviewMessageModelCopyWith<$Res> get firstQuestion;

}
/// @nodoc
class __$CreatedInterviewModelCopyWithImpl<$Res>
    implements _$CreatedInterviewModelCopyWith<$Res> {
  __$CreatedInterviewModelCopyWithImpl(this._self, this._then);

  final _CreatedInterviewModel _self;
  final $Res Function(_CreatedInterviewModel) _then;

/// Create a copy of CreatedInterviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? status = null,Object? progress = null,Object? firstQuestion = null,}) {
  return _then(_CreatedInterviewModel(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as ProgressModel,firstQuestion: null == firstQuestion ? _self.firstQuestion : firstQuestion // ignore: cast_nullable_to_non_nullable
as InterviewMessageModel,
  ));
}

/// Create a copy of CreatedInterviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgressModelCopyWith<$Res> get progress {
  
  return $ProgressModelCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}/// Create a copy of CreatedInterviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InterviewMessageModelCopyWith<$Res> get firstQuestion {
  
  return $InterviewMessageModelCopyWith<$Res>(_self.firstQuestion, (value) {
    return _then(_self.copyWith(firstQuestion: value));
  });
}
}


/// @nodoc
mixin _$SkipResultModel {

 InterviewMessageModel? get next; ProgressModel get progress; bool get done;
/// Create a copy of SkipResultModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkipResultModelCopyWith<SkipResultModel> get copyWith => _$SkipResultModelCopyWithImpl<SkipResultModel>(this as SkipResultModel, _$identity);

  /// Serializes this SkipResultModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkipResultModel&&(identical(other.next, next) || other.next == next)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.done, done) || other.done == done));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,next,progress,done);

@override
String toString() {
  return 'SkipResultModel(next: $next, progress: $progress, done: $done)';
}


}

/// @nodoc
abstract mixin class $SkipResultModelCopyWith<$Res>  {
  factory $SkipResultModelCopyWith(SkipResultModel value, $Res Function(SkipResultModel) _then) = _$SkipResultModelCopyWithImpl;
@useResult
$Res call({
 InterviewMessageModel? next, ProgressModel progress, bool done
});


$InterviewMessageModelCopyWith<$Res>? get next;$ProgressModelCopyWith<$Res> get progress;

}
/// @nodoc
class _$SkipResultModelCopyWithImpl<$Res>
    implements $SkipResultModelCopyWith<$Res> {
  _$SkipResultModelCopyWithImpl(this._self, this._then);

  final SkipResultModel _self;
  final $Res Function(SkipResultModel) _then;

/// Create a copy of SkipResultModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? next = freezed,Object? progress = null,Object? done = null,}) {
  return _then(_self.copyWith(
next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as InterviewMessageModel?,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as ProgressModel,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SkipResultModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InterviewMessageModelCopyWith<$Res>? get next {
    if (_self.next == null) {
    return null;
  }

  return $InterviewMessageModelCopyWith<$Res>(_self.next!, (value) {
    return _then(_self.copyWith(next: value));
  });
}/// Create a copy of SkipResultModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgressModelCopyWith<$Res> get progress {
  
  return $ProgressModelCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}


/// Adds pattern-matching-related methods to [SkipResultModel].
extension SkipResultModelPatterns on SkipResultModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkipResultModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkipResultModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkipResultModel value)  $default,){
final _that = this;
switch (_that) {
case _SkipResultModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkipResultModel value)?  $default,){
final _that = this;
switch (_that) {
case _SkipResultModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InterviewMessageModel? next,  ProgressModel progress,  bool done)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkipResultModel() when $default != null:
return $default(_that.next,_that.progress,_that.done);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InterviewMessageModel? next,  ProgressModel progress,  bool done)  $default,) {final _that = this;
switch (_that) {
case _SkipResultModel():
return $default(_that.next,_that.progress,_that.done);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InterviewMessageModel? next,  ProgressModel progress,  bool done)?  $default,) {final _that = this;
switch (_that) {
case _SkipResultModel() when $default != null:
return $default(_that.next,_that.progress,_that.done);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SkipResultModel extends SkipResultModel {
  const _SkipResultModel({this.next, required this.progress, this.done = false}): super._();
  factory _SkipResultModel.fromJson(Map<String, dynamic> json) => _$SkipResultModelFromJson(json);

@override final  InterviewMessageModel? next;
@override final  ProgressModel progress;
@override@JsonKey() final  bool done;

/// Create a copy of SkipResultModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkipResultModelCopyWith<_SkipResultModel> get copyWith => __$SkipResultModelCopyWithImpl<_SkipResultModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkipResultModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkipResultModel&&(identical(other.next, next) || other.next == next)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.done, done) || other.done == done));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,next,progress,done);

@override
String toString() {
  return 'SkipResultModel(next: $next, progress: $progress, done: $done)';
}


}

/// @nodoc
abstract mixin class _$SkipResultModelCopyWith<$Res> implements $SkipResultModelCopyWith<$Res> {
  factory _$SkipResultModelCopyWith(_SkipResultModel value, $Res Function(_SkipResultModel) _then) = __$SkipResultModelCopyWithImpl;
@override @useResult
$Res call({
 InterviewMessageModel? next, ProgressModel progress, bool done
});


@override $InterviewMessageModelCopyWith<$Res>? get next;@override $ProgressModelCopyWith<$Res> get progress;

}
/// @nodoc
class __$SkipResultModelCopyWithImpl<$Res>
    implements _$SkipResultModelCopyWith<$Res> {
  __$SkipResultModelCopyWithImpl(this._self, this._then);

  final _SkipResultModel _self;
  final $Res Function(_SkipResultModel) _then;

/// Create a copy of SkipResultModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? next = freezed,Object? progress = null,Object? done = null,}) {
  return _then(_SkipResultModel(
next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as InterviewMessageModel?,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as ProgressModel,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SkipResultModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InterviewMessageModelCopyWith<$Res>? get next {
    if (_self.next == null) {
    return null;
  }

  return $InterviewMessageModelCopyWith<$Res>(_self.next!, (value) {
    return _then(_self.copyWith(next: value));
  });
}/// Create a copy of SkipResultModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgressModelCopyWith<$Res> get progress {
  
  return $ProgressModelCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}


/// @nodoc
mixin _$ResumedInterviewModel {

 String get status; ProgressModel get progress; List<InterviewMessageModel> get messages;
/// Create a copy of ResumedInterviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumedInterviewModelCopyWith<ResumedInterviewModel> get copyWith => _$ResumedInterviewModelCopyWithImpl<ResumedInterviewModel>(this as ResumedInterviewModel, _$identity);

  /// Serializes this ResumedInterviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumedInterviewModel&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&const DeepCollectionEquality().equals(other.messages, messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,progress,const DeepCollectionEquality().hash(messages));

@override
String toString() {
  return 'ResumedInterviewModel(status: $status, progress: $progress, messages: $messages)';
}


}

/// @nodoc
abstract mixin class $ResumedInterviewModelCopyWith<$Res>  {
  factory $ResumedInterviewModelCopyWith(ResumedInterviewModel value, $Res Function(ResumedInterviewModel) _then) = _$ResumedInterviewModelCopyWithImpl;
@useResult
$Res call({
 String status, ProgressModel progress, List<InterviewMessageModel> messages
});


$ProgressModelCopyWith<$Res> get progress;

}
/// @nodoc
class _$ResumedInterviewModelCopyWithImpl<$Res>
    implements $ResumedInterviewModelCopyWith<$Res> {
  _$ResumedInterviewModelCopyWithImpl(this._self, this._then);

  final ResumedInterviewModel _self;
  final $Res Function(ResumedInterviewModel) _then;

/// Create a copy of ResumedInterviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? progress = null,Object? messages = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as ProgressModel,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<InterviewMessageModel>,
  ));
}
/// Create a copy of ResumedInterviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgressModelCopyWith<$Res> get progress {
  
  return $ProgressModelCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}


/// Adds pattern-matching-related methods to [ResumedInterviewModel].
extension ResumedInterviewModelPatterns on ResumedInterviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumedInterviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumedInterviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumedInterviewModel value)  $default,){
final _that = this;
switch (_that) {
case _ResumedInterviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumedInterviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _ResumedInterviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  ProgressModel progress,  List<InterviewMessageModel> messages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumedInterviewModel() when $default != null:
return $default(_that.status,_that.progress,_that.messages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  ProgressModel progress,  List<InterviewMessageModel> messages)  $default,) {final _that = this;
switch (_that) {
case _ResumedInterviewModel():
return $default(_that.status,_that.progress,_that.messages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  ProgressModel progress,  List<InterviewMessageModel> messages)?  $default,) {final _that = this;
switch (_that) {
case _ResumedInterviewModel() when $default != null:
return $default(_that.status,_that.progress,_that.messages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResumedInterviewModel extends ResumedInterviewModel {
  const _ResumedInterviewModel({required this.status, required this.progress, final  List<InterviewMessageModel> messages = const <InterviewMessageModel>[]}): _messages = messages,super._();
  factory _ResumedInterviewModel.fromJson(Map<String, dynamic> json) => _$ResumedInterviewModelFromJson(json);

@override final  String status;
@override final  ProgressModel progress;
 final  List<InterviewMessageModel> _messages;
@override@JsonKey() List<InterviewMessageModel> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of ResumedInterviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumedInterviewModelCopyWith<_ResumedInterviewModel> get copyWith => __$ResumedInterviewModelCopyWithImpl<_ResumedInterviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResumedInterviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumedInterviewModel&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&const DeepCollectionEquality().equals(other._messages, _messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,progress,const DeepCollectionEquality().hash(_messages));

@override
String toString() {
  return 'ResumedInterviewModel(status: $status, progress: $progress, messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$ResumedInterviewModelCopyWith<$Res> implements $ResumedInterviewModelCopyWith<$Res> {
  factory _$ResumedInterviewModelCopyWith(_ResumedInterviewModel value, $Res Function(_ResumedInterviewModel) _then) = __$ResumedInterviewModelCopyWithImpl;
@override @useResult
$Res call({
 String status, ProgressModel progress, List<InterviewMessageModel> messages
});


@override $ProgressModelCopyWith<$Res> get progress;

}
/// @nodoc
class __$ResumedInterviewModelCopyWithImpl<$Res>
    implements _$ResumedInterviewModelCopyWith<$Res> {
  __$ResumedInterviewModelCopyWithImpl(this._self, this._then);

  final _ResumedInterviewModel _self;
  final $Res Function(_ResumedInterviewModel) _then;

/// Create a copy of ResumedInterviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? progress = null,Object? messages = null,}) {
  return _then(_ResumedInterviewModel(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as ProgressModel,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<InterviewMessageModel>,
  ));
}

/// Create a copy of ResumedInterviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgressModelCopyWith<$Res> get progress {
  
  return $ProgressModelCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}


/// @nodoc
mixin _$CriterionScoreModel {

 String get criterion; int get score; num get weight;
/// Create a copy of CriterionScoreModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CriterionScoreModelCopyWith<CriterionScoreModel> get copyWith => _$CriterionScoreModelCopyWithImpl<CriterionScoreModel>(this as CriterionScoreModel, _$identity);

  /// Serializes this CriterionScoreModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CriterionScoreModel&&(identical(other.criterion, criterion) || other.criterion == criterion)&&(identical(other.score, score) || other.score == score)&&(identical(other.weight, weight) || other.weight == weight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,criterion,score,weight);

@override
String toString() {
  return 'CriterionScoreModel(criterion: $criterion, score: $score, weight: $weight)';
}


}

/// @nodoc
abstract mixin class $CriterionScoreModelCopyWith<$Res>  {
  factory $CriterionScoreModelCopyWith(CriterionScoreModel value, $Res Function(CriterionScoreModel) _then) = _$CriterionScoreModelCopyWithImpl;
@useResult
$Res call({
 String criterion, int score, num weight
});




}
/// @nodoc
class _$CriterionScoreModelCopyWithImpl<$Res>
    implements $CriterionScoreModelCopyWith<$Res> {
  _$CriterionScoreModelCopyWithImpl(this._self, this._then);

  final CriterionScoreModel _self;
  final $Res Function(CriterionScoreModel) _then;

/// Create a copy of CriterionScoreModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? criterion = null,Object? score = null,Object? weight = null,}) {
  return _then(_self.copyWith(
criterion: null == criterion ? _self.criterion : criterion // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [CriterionScoreModel].
extension CriterionScoreModelPatterns on CriterionScoreModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CriterionScoreModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CriterionScoreModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CriterionScoreModel value)  $default,){
final _that = this;
switch (_that) {
case _CriterionScoreModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CriterionScoreModel value)?  $default,){
final _that = this;
switch (_that) {
case _CriterionScoreModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String criterion,  int score,  num weight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CriterionScoreModel() when $default != null:
return $default(_that.criterion,_that.score,_that.weight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String criterion,  int score,  num weight)  $default,) {final _that = this;
switch (_that) {
case _CriterionScoreModel():
return $default(_that.criterion,_that.score,_that.weight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String criterion,  int score,  num weight)?  $default,) {final _that = this;
switch (_that) {
case _CriterionScoreModel() when $default != null:
return $default(_that.criterion,_that.score,_that.weight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CriterionScoreModel extends CriterionScoreModel {
  const _CriterionScoreModel({required this.criterion, required this.score, this.weight = 0}): super._();
  factory _CriterionScoreModel.fromJson(Map<String, dynamic> json) => _$CriterionScoreModelFromJson(json);

@override final  String criterion;
@override final  int score;
@override@JsonKey() final  num weight;

/// Create a copy of CriterionScoreModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CriterionScoreModelCopyWith<_CriterionScoreModel> get copyWith => __$CriterionScoreModelCopyWithImpl<_CriterionScoreModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CriterionScoreModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CriterionScoreModel&&(identical(other.criterion, criterion) || other.criterion == criterion)&&(identical(other.score, score) || other.score == score)&&(identical(other.weight, weight) || other.weight == weight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,criterion,score,weight);

@override
String toString() {
  return 'CriterionScoreModel(criterion: $criterion, score: $score, weight: $weight)';
}


}

/// @nodoc
abstract mixin class _$CriterionScoreModelCopyWith<$Res> implements $CriterionScoreModelCopyWith<$Res> {
  factory _$CriterionScoreModelCopyWith(_CriterionScoreModel value, $Res Function(_CriterionScoreModel) _then) = __$CriterionScoreModelCopyWithImpl;
@override @useResult
$Res call({
 String criterion, int score, num weight
});




}
/// @nodoc
class __$CriterionScoreModelCopyWithImpl<$Res>
    implements _$CriterionScoreModelCopyWith<$Res> {
  __$CriterionScoreModelCopyWithImpl(this._self, this._then);

  final _CriterionScoreModel _self;
  final $Res Function(_CriterionScoreModel) _then;

/// Create a copy of CriterionScoreModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? criterion = null,Object? score = null,Object? weight = null,}) {
  return _then(_CriterionScoreModel(
criterion: null == criterion ? _self.criterion : criterion // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}


/// @nodoc
mixin _$InterviewReportModel {

 int get overallScore; bool get showScore; String get passResult; String get passReason; String get weightPreset; List<CriterionScoreModel> get scores;
/// Create a copy of InterviewReportModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterviewReportModelCopyWith<InterviewReportModel> get copyWith => _$InterviewReportModelCopyWithImpl<InterviewReportModel>(this as InterviewReportModel, _$identity);

  /// Serializes this InterviewReportModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterviewReportModel&&(identical(other.overallScore, overallScore) || other.overallScore == overallScore)&&(identical(other.showScore, showScore) || other.showScore == showScore)&&(identical(other.passResult, passResult) || other.passResult == passResult)&&(identical(other.passReason, passReason) || other.passReason == passReason)&&(identical(other.weightPreset, weightPreset) || other.weightPreset == weightPreset)&&const DeepCollectionEquality().equals(other.scores, scores));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,overallScore,showScore,passResult,passReason,weightPreset,const DeepCollectionEquality().hash(scores));

@override
String toString() {
  return 'InterviewReportModel(overallScore: $overallScore, showScore: $showScore, passResult: $passResult, passReason: $passReason, weightPreset: $weightPreset, scores: $scores)';
}


}

/// @nodoc
abstract mixin class $InterviewReportModelCopyWith<$Res>  {
  factory $InterviewReportModelCopyWith(InterviewReportModel value, $Res Function(InterviewReportModel) _then) = _$InterviewReportModelCopyWithImpl;
@useResult
$Res call({
 int overallScore, bool showScore, String passResult, String passReason, String weightPreset, List<CriterionScoreModel> scores
});




}
/// @nodoc
class _$InterviewReportModelCopyWithImpl<$Res>
    implements $InterviewReportModelCopyWith<$Res> {
  _$InterviewReportModelCopyWithImpl(this._self, this._then);

  final InterviewReportModel _self;
  final $Res Function(InterviewReportModel) _then;

/// Create a copy of InterviewReportModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? overallScore = null,Object? showScore = null,Object? passResult = null,Object? passReason = null,Object? weightPreset = null,Object? scores = null,}) {
  return _then(_self.copyWith(
overallScore: null == overallScore ? _self.overallScore : overallScore // ignore: cast_nullable_to_non_nullable
as int,showScore: null == showScore ? _self.showScore : showScore // ignore: cast_nullable_to_non_nullable
as bool,passResult: null == passResult ? _self.passResult : passResult // ignore: cast_nullable_to_non_nullable
as String,passReason: null == passReason ? _self.passReason : passReason // ignore: cast_nullable_to_non_nullable
as String,weightPreset: null == weightPreset ? _self.weightPreset : weightPreset // ignore: cast_nullable_to_non_nullable
as String,scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as List<CriterionScoreModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [InterviewReportModel].
extension InterviewReportModelPatterns on InterviewReportModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InterviewReportModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InterviewReportModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InterviewReportModel value)  $default,){
final _that = this;
switch (_that) {
case _InterviewReportModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InterviewReportModel value)?  $default,){
final _that = this;
switch (_that) {
case _InterviewReportModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int overallScore,  bool showScore,  String passResult,  String passReason,  String weightPreset,  List<CriterionScoreModel> scores)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InterviewReportModel() when $default != null:
return $default(_that.overallScore,_that.showScore,_that.passResult,_that.passReason,_that.weightPreset,_that.scores);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int overallScore,  bool showScore,  String passResult,  String passReason,  String weightPreset,  List<CriterionScoreModel> scores)  $default,) {final _that = this;
switch (_that) {
case _InterviewReportModel():
return $default(_that.overallScore,_that.showScore,_that.passResult,_that.passReason,_that.weightPreset,_that.scores);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int overallScore,  bool showScore,  String passResult,  String passReason,  String weightPreset,  List<CriterionScoreModel> scores)?  $default,) {final _that = this;
switch (_that) {
case _InterviewReportModel() when $default != null:
return $default(_that.overallScore,_that.showScore,_that.passResult,_that.passReason,_that.weightPreset,_that.scores);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InterviewReportModel extends InterviewReportModel {
  const _InterviewReportModel({required this.overallScore, this.showScore = true, required this.passResult, this.passReason = '', this.weightPreset = 'general', final  List<CriterionScoreModel> scores = const <CriterionScoreModel>[]}): _scores = scores,super._();
  factory _InterviewReportModel.fromJson(Map<String, dynamic> json) => _$InterviewReportModelFromJson(json);

@override final  int overallScore;
@override@JsonKey() final  bool showScore;
@override final  String passResult;
@override@JsonKey() final  String passReason;
@override@JsonKey() final  String weightPreset;
 final  List<CriterionScoreModel> _scores;
@override@JsonKey() List<CriterionScoreModel> get scores {
  if (_scores is EqualUnmodifiableListView) return _scores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scores);
}


/// Create a copy of InterviewReportModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterviewReportModelCopyWith<_InterviewReportModel> get copyWith => __$InterviewReportModelCopyWithImpl<_InterviewReportModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterviewReportModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InterviewReportModel&&(identical(other.overallScore, overallScore) || other.overallScore == overallScore)&&(identical(other.showScore, showScore) || other.showScore == showScore)&&(identical(other.passResult, passResult) || other.passResult == passResult)&&(identical(other.passReason, passReason) || other.passReason == passReason)&&(identical(other.weightPreset, weightPreset) || other.weightPreset == weightPreset)&&const DeepCollectionEquality().equals(other._scores, _scores));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,overallScore,showScore,passResult,passReason,weightPreset,const DeepCollectionEquality().hash(_scores));

@override
String toString() {
  return 'InterviewReportModel(overallScore: $overallScore, showScore: $showScore, passResult: $passResult, passReason: $passReason, weightPreset: $weightPreset, scores: $scores)';
}


}

/// @nodoc
abstract mixin class _$InterviewReportModelCopyWith<$Res> implements $InterviewReportModelCopyWith<$Res> {
  factory _$InterviewReportModelCopyWith(_InterviewReportModel value, $Res Function(_InterviewReportModel) _then) = __$InterviewReportModelCopyWithImpl;
@override @useResult
$Res call({
 int overallScore, bool showScore, String passResult, String passReason, String weightPreset, List<CriterionScoreModel> scores
});




}
/// @nodoc
class __$InterviewReportModelCopyWithImpl<$Res>
    implements _$InterviewReportModelCopyWith<$Res> {
  __$InterviewReportModelCopyWithImpl(this._self, this._then);

  final _InterviewReportModel _self;
  final $Res Function(_InterviewReportModel) _then;

/// Create a copy of InterviewReportModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? overallScore = null,Object? showScore = null,Object? passResult = null,Object? passReason = null,Object? weightPreset = null,Object? scores = null,}) {
  return _then(_InterviewReportModel(
overallScore: null == overallScore ? _self.overallScore : overallScore // ignore: cast_nullable_to_non_nullable
as int,showScore: null == showScore ? _self.showScore : showScore // ignore: cast_nullable_to_non_nullable
as bool,passResult: null == passResult ? _self.passResult : passResult // ignore: cast_nullable_to_non_nullable
as String,passReason: null == passReason ? _self.passReason : passReason // ignore: cast_nullable_to_non_nullable
as String,weightPreset: null == weightPreset ? _self.weightPreset : weightPreset // ignore: cast_nullable_to_non_nullable
as String,scores: null == scores ? _self._scores : scores // ignore: cast_nullable_to_non_nullable
as List<CriterionScoreModel>,
  ));
}


}


/// @nodoc
mixin _$CompleteInterviewModel {

 String get sessionId; String get status; InterviewReportModel get report;
/// Create a copy of CompleteInterviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompleteInterviewModelCopyWith<CompleteInterviewModel> get copyWith => _$CompleteInterviewModelCopyWithImpl<CompleteInterviewModel>(this as CompleteInterviewModel, _$identity);

  /// Serializes this CompleteInterviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteInterviewModel&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.status, status) || other.status == status)&&(identical(other.report, report) || other.report == report));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,status,report);

@override
String toString() {
  return 'CompleteInterviewModel(sessionId: $sessionId, status: $status, report: $report)';
}


}

/// @nodoc
abstract mixin class $CompleteInterviewModelCopyWith<$Res>  {
  factory $CompleteInterviewModelCopyWith(CompleteInterviewModel value, $Res Function(CompleteInterviewModel) _then) = _$CompleteInterviewModelCopyWithImpl;
@useResult
$Res call({
 String sessionId, String status, InterviewReportModel report
});


$InterviewReportModelCopyWith<$Res> get report;

}
/// @nodoc
class _$CompleteInterviewModelCopyWithImpl<$Res>
    implements $CompleteInterviewModelCopyWith<$Res> {
  _$CompleteInterviewModelCopyWithImpl(this._self, this._then);

  final CompleteInterviewModel _self;
  final $Res Function(CompleteInterviewModel) _then;

/// Create a copy of CompleteInterviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? status = null,Object? report = null,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,report: null == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as InterviewReportModel,
  ));
}
/// Create a copy of CompleteInterviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InterviewReportModelCopyWith<$Res> get report {
  
  return $InterviewReportModelCopyWith<$Res>(_self.report, (value) {
    return _then(_self.copyWith(report: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompleteInterviewModel].
extension CompleteInterviewModelPatterns on CompleteInterviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompleteInterviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompleteInterviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompleteInterviewModel value)  $default,){
final _that = this;
switch (_that) {
case _CompleteInterviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompleteInterviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _CompleteInterviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String status,  InterviewReportModel report)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompleteInterviewModel() when $default != null:
return $default(_that.sessionId,_that.status,_that.report);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String status,  InterviewReportModel report)  $default,) {final _that = this;
switch (_that) {
case _CompleteInterviewModel():
return $default(_that.sessionId,_that.status,_that.report);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String status,  InterviewReportModel report)?  $default,) {final _that = this;
switch (_that) {
case _CompleteInterviewModel() when $default != null:
return $default(_that.sessionId,_that.status,_that.report);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompleteInterviewModel implements CompleteInterviewModel {
  const _CompleteInterviewModel({required this.sessionId, required this.status, required this.report});
  factory _CompleteInterviewModel.fromJson(Map<String, dynamic> json) => _$CompleteInterviewModelFromJson(json);

@override final  String sessionId;
@override final  String status;
@override final  InterviewReportModel report;

/// Create a copy of CompleteInterviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompleteInterviewModelCopyWith<_CompleteInterviewModel> get copyWith => __$CompleteInterviewModelCopyWithImpl<_CompleteInterviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompleteInterviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompleteInterviewModel&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.status, status) || other.status == status)&&(identical(other.report, report) || other.report == report));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,status,report);

@override
String toString() {
  return 'CompleteInterviewModel(sessionId: $sessionId, status: $status, report: $report)';
}


}

/// @nodoc
abstract mixin class _$CompleteInterviewModelCopyWith<$Res> implements $CompleteInterviewModelCopyWith<$Res> {
  factory _$CompleteInterviewModelCopyWith(_CompleteInterviewModel value, $Res Function(_CompleteInterviewModel) _then) = __$CompleteInterviewModelCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String status, InterviewReportModel report
});


@override $InterviewReportModelCopyWith<$Res> get report;

}
/// @nodoc
class __$CompleteInterviewModelCopyWithImpl<$Res>
    implements _$CompleteInterviewModelCopyWith<$Res> {
  __$CompleteInterviewModelCopyWithImpl(this._self, this._then);

  final _CompleteInterviewModel _self;
  final $Res Function(_CompleteInterviewModel) _then;

/// Create a copy of CompleteInterviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? status = null,Object? report = null,}) {
  return _then(_CompleteInterviewModel(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,report: null == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as InterviewReportModel,
  ));
}

/// Create a copy of CompleteInterviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InterviewReportModelCopyWith<$Res> get report {
  
  return $InterviewReportModelCopyWith<$Res>(_self.report, (value) {
    return _then(_self.copyWith(report: value));
  });
}
}


/// @nodoc
mixin _$InterviewSessionModel {

 String get id; String get interviewType; String get difficulty; String get status; String? get role; ProgressModel get progress; DateTime get createdAt;
/// Create a copy of InterviewSessionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterviewSessionModelCopyWith<InterviewSessionModel> get copyWith => _$InterviewSessionModelCopyWithImpl<InterviewSessionModel>(this as InterviewSessionModel, _$identity);

  /// Serializes this InterviewSessionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterviewSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.interviewType, interviewType) || other.interviewType == interviewType)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.status, status) || other.status == status)&&(identical(other.role, role) || other.role == role)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,interviewType,difficulty,status,role,progress,createdAt);

@override
String toString() {
  return 'InterviewSessionModel(id: $id, interviewType: $interviewType, difficulty: $difficulty, status: $status, role: $role, progress: $progress, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $InterviewSessionModelCopyWith<$Res>  {
  factory $InterviewSessionModelCopyWith(InterviewSessionModel value, $Res Function(InterviewSessionModel) _then) = _$InterviewSessionModelCopyWithImpl;
@useResult
$Res call({
 String id, String interviewType, String difficulty, String status, String? role, ProgressModel progress, DateTime createdAt
});


$ProgressModelCopyWith<$Res> get progress;

}
/// @nodoc
class _$InterviewSessionModelCopyWithImpl<$Res>
    implements $InterviewSessionModelCopyWith<$Res> {
  _$InterviewSessionModelCopyWithImpl(this._self, this._then);

  final InterviewSessionModel _self;
  final $Res Function(InterviewSessionModel) _then;

/// Create a copy of InterviewSessionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? interviewType = null,Object? difficulty = null,Object? status = null,Object? role = freezed,Object? progress = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,interviewType: null == interviewType ? _self.interviewType : interviewType // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as ProgressModel,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of InterviewSessionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgressModelCopyWith<$Res> get progress {
  
  return $ProgressModelCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}


/// Adds pattern-matching-related methods to [InterviewSessionModel].
extension InterviewSessionModelPatterns on InterviewSessionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InterviewSessionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InterviewSessionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InterviewSessionModel value)  $default,){
final _that = this;
switch (_that) {
case _InterviewSessionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InterviewSessionModel value)?  $default,){
final _that = this;
switch (_that) {
case _InterviewSessionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String interviewType,  String difficulty,  String status,  String? role,  ProgressModel progress,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InterviewSessionModel() when $default != null:
return $default(_that.id,_that.interviewType,_that.difficulty,_that.status,_that.role,_that.progress,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String interviewType,  String difficulty,  String status,  String? role,  ProgressModel progress,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _InterviewSessionModel():
return $default(_that.id,_that.interviewType,_that.difficulty,_that.status,_that.role,_that.progress,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String interviewType,  String difficulty,  String status,  String? role,  ProgressModel progress,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _InterviewSessionModel() when $default != null:
return $default(_that.id,_that.interviewType,_that.difficulty,_that.status,_that.role,_that.progress,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InterviewSessionModel implements InterviewSessionModel {
  const _InterviewSessionModel({required this.id, required this.interviewType, required this.difficulty, required this.status, this.role, required this.progress, required this.createdAt});
  factory _InterviewSessionModel.fromJson(Map<String, dynamic> json) => _$InterviewSessionModelFromJson(json);

@override final  String id;
@override final  String interviewType;
@override final  String difficulty;
@override final  String status;
@override final  String? role;
@override final  ProgressModel progress;
@override final  DateTime createdAt;

/// Create a copy of InterviewSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterviewSessionModelCopyWith<_InterviewSessionModel> get copyWith => __$InterviewSessionModelCopyWithImpl<_InterviewSessionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterviewSessionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InterviewSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.interviewType, interviewType) || other.interviewType == interviewType)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.status, status) || other.status == status)&&(identical(other.role, role) || other.role == role)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,interviewType,difficulty,status,role,progress,createdAt);

@override
String toString() {
  return 'InterviewSessionModel(id: $id, interviewType: $interviewType, difficulty: $difficulty, status: $status, role: $role, progress: $progress, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$InterviewSessionModelCopyWith<$Res> implements $InterviewSessionModelCopyWith<$Res> {
  factory _$InterviewSessionModelCopyWith(_InterviewSessionModel value, $Res Function(_InterviewSessionModel) _then) = __$InterviewSessionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String interviewType, String difficulty, String status, String? role, ProgressModel progress, DateTime createdAt
});


@override $ProgressModelCopyWith<$Res> get progress;

}
/// @nodoc
class __$InterviewSessionModelCopyWithImpl<$Res>
    implements _$InterviewSessionModelCopyWith<$Res> {
  __$InterviewSessionModelCopyWithImpl(this._self, this._then);

  final _InterviewSessionModel _self;
  final $Res Function(_InterviewSessionModel) _then;

/// Create a copy of InterviewSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? interviewType = null,Object? difficulty = null,Object? status = null,Object? role = freezed,Object? progress = null,Object? createdAt = null,}) {
  return _then(_InterviewSessionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,interviewType: null == interviewType ? _self.interviewType : interviewType // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as ProgressModel,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of InterviewSessionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgressModelCopyWith<$Res> get progress {
  
  return $ProgressModelCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}


/// @nodoc
mixin _$SessionFeedbackModel {

 String get rating; String? get comment;
/// Create a copy of SessionFeedbackModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionFeedbackModelCopyWith<SessionFeedbackModel> get copyWith => _$SessionFeedbackModelCopyWithImpl<SessionFeedbackModel>(this as SessionFeedbackModel, _$identity);

  /// Serializes this SessionFeedbackModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionFeedbackModel&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rating,comment);

@override
String toString() {
  return 'SessionFeedbackModel(rating: $rating, comment: $comment)';
}


}

/// @nodoc
abstract mixin class $SessionFeedbackModelCopyWith<$Res>  {
  factory $SessionFeedbackModelCopyWith(SessionFeedbackModel value, $Res Function(SessionFeedbackModel) _then) = _$SessionFeedbackModelCopyWithImpl;
@useResult
$Res call({
 String rating, String? comment
});




}
/// @nodoc
class _$SessionFeedbackModelCopyWithImpl<$Res>
    implements $SessionFeedbackModelCopyWith<$Res> {
  _$SessionFeedbackModelCopyWithImpl(this._self, this._then);

  final SessionFeedbackModel _self;
  final $Res Function(SessionFeedbackModel) _then;

/// Create a copy of SessionFeedbackModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rating = null,Object? comment = freezed,}) {
  return _then(_self.copyWith(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as String,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionFeedbackModel].
extension SessionFeedbackModelPatterns on SessionFeedbackModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionFeedbackModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionFeedbackModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionFeedbackModel value)  $default,){
final _that = this;
switch (_that) {
case _SessionFeedbackModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionFeedbackModel value)?  $default,){
final _that = this;
switch (_that) {
case _SessionFeedbackModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String rating,  String? comment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionFeedbackModel() when $default != null:
return $default(_that.rating,_that.comment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String rating,  String? comment)  $default,) {final _that = this;
switch (_that) {
case _SessionFeedbackModel():
return $default(_that.rating,_that.comment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String rating,  String? comment)?  $default,) {final _that = this;
switch (_that) {
case _SessionFeedbackModel() when $default != null:
return $default(_that.rating,_that.comment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionFeedbackModel extends SessionFeedbackModel {
  const _SessionFeedbackModel({required this.rating, this.comment}): super._();
  factory _SessionFeedbackModel.fromJson(Map<String, dynamic> json) => _$SessionFeedbackModelFromJson(json);

@override final  String rating;
@override final  String? comment;

/// Create a copy of SessionFeedbackModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionFeedbackModelCopyWith<_SessionFeedbackModel> get copyWith => __$SessionFeedbackModelCopyWithImpl<_SessionFeedbackModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionFeedbackModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionFeedbackModel&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rating,comment);

@override
String toString() {
  return 'SessionFeedbackModel(rating: $rating, comment: $comment)';
}


}

/// @nodoc
abstract mixin class _$SessionFeedbackModelCopyWith<$Res> implements $SessionFeedbackModelCopyWith<$Res> {
  factory _$SessionFeedbackModelCopyWith(_SessionFeedbackModel value, $Res Function(_SessionFeedbackModel) _then) = __$SessionFeedbackModelCopyWithImpl;
@override @useResult
$Res call({
 String rating, String? comment
});




}
/// @nodoc
class __$SessionFeedbackModelCopyWithImpl<$Res>
    implements _$SessionFeedbackModelCopyWith<$Res> {
  __$SessionFeedbackModelCopyWithImpl(this._self, this._then);

  final _SessionFeedbackModel _self;
  final $Res Function(_SessionFeedbackModel) _then;

/// Create a copy of SessionFeedbackModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rating = null,Object? comment = freezed,}) {
  return _then(_SessionFeedbackModel(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as String,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$InterviewDetailModel {

 InterviewSessionModel get session; List<InterviewMessageModel> get messages; InterviewReportModel? get report; SessionFeedbackModel? get feedback;
/// Create a copy of InterviewDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterviewDetailModelCopyWith<InterviewDetailModel> get copyWith => _$InterviewDetailModelCopyWithImpl<InterviewDetailModel>(this as InterviewDetailModel, _$identity);

  /// Serializes this InterviewDetailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterviewDetailModel&&(identical(other.session, session) || other.session == session)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.report, report) || other.report == report)&&(identical(other.feedback, feedback) || other.feedback == feedback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,session,const DeepCollectionEquality().hash(messages),report,feedback);

@override
String toString() {
  return 'InterviewDetailModel(session: $session, messages: $messages, report: $report, feedback: $feedback)';
}


}

/// @nodoc
abstract mixin class $InterviewDetailModelCopyWith<$Res>  {
  factory $InterviewDetailModelCopyWith(InterviewDetailModel value, $Res Function(InterviewDetailModel) _then) = _$InterviewDetailModelCopyWithImpl;
@useResult
$Res call({
 InterviewSessionModel session, List<InterviewMessageModel> messages, InterviewReportModel? report, SessionFeedbackModel? feedback
});


$InterviewSessionModelCopyWith<$Res> get session;$InterviewReportModelCopyWith<$Res>? get report;$SessionFeedbackModelCopyWith<$Res>? get feedback;

}
/// @nodoc
class _$InterviewDetailModelCopyWithImpl<$Res>
    implements $InterviewDetailModelCopyWith<$Res> {
  _$InterviewDetailModelCopyWithImpl(this._self, this._then);

  final InterviewDetailModel _self;
  final $Res Function(InterviewDetailModel) _then;

/// Create a copy of InterviewDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? session = null,Object? messages = null,Object? report = freezed,Object? feedback = freezed,}) {
  return _then(_self.copyWith(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as InterviewSessionModel,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<InterviewMessageModel>,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as InterviewReportModel?,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as SessionFeedbackModel?,
  ));
}
/// Create a copy of InterviewDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InterviewSessionModelCopyWith<$Res> get session {
  
  return $InterviewSessionModelCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of InterviewDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InterviewReportModelCopyWith<$Res>? get report {
    if (_self.report == null) {
    return null;
  }

  return $InterviewReportModelCopyWith<$Res>(_self.report!, (value) {
    return _then(_self.copyWith(report: value));
  });
}/// Create a copy of InterviewDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionFeedbackModelCopyWith<$Res>? get feedback {
    if (_self.feedback == null) {
    return null;
  }

  return $SessionFeedbackModelCopyWith<$Res>(_self.feedback!, (value) {
    return _then(_self.copyWith(feedback: value));
  });
}
}


/// Adds pattern-matching-related methods to [InterviewDetailModel].
extension InterviewDetailModelPatterns on InterviewDetailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InterviewDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InterviewDetailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InterviewDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _InterviewDetailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InterviewDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _InterviewDetailModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InterviewSessionModel session,  List<InterviewMessageModel> messages,  InterviewReportModel? report,  SessionFeedbackModel? feedback)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InterviewDetailModel() when $default != null:
return $default(_that.session,_that.messages,_that.report,_that.feedback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InterviewSessionModel session,  List<InterviewMessageModel> messages,  InterviewReportModel? report,  SessionFeedbackModel? feedback)  $default,) {final _that = this;
switch (_that) {
case _InterviewDetailModel():
return $default(_that.session,_that.messages,_that.report,_that.feedback);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InterviewSessionModel session,  List<InterviewMessageModel> messages,  InterviewReportModel? report,  SessionFeedbackModel? feedback)?  $default,) {final _that = this;
switch (_that) {
case _InterviewDetailModel() when $default != null:
return $default(_that.session,_that.messages,_that.report,_that.feedback);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InterviewDetailModel extends InterviewDetailModel {
  const _InterviewDetailModel({required this.session, final  List<InterviewMessageModel> messages = const <InterviewMessageModel>[], this.report, this.feedback}): _messages = messages,super._();
  factory _InterviewDetailModel.fromJson(Map<String, dynamic> json) => _$InterviewDetailModelFromJson(json);

@override final  InterviewSessionModel session;
 final  List<InterviewMessageModel> _messages;
@override@JsonKey() List<InterviewMessageModel> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override final  InterviewReportModel? report;
@override final  SessionFeedbackModel? feedback;

/// Create a copy of InterviewDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterviewDetailModelCopyWith<_InterviewDetailModel> get copyWith => __$InterviewDetailModelCopyWithImpl<_InterviewDetailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterviewDetailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InterviewDetailModel&&(identical(other.session, session) || other.session == session)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.report, report) || other.report == report)&&(identical(other.feedback, feedback) || other.feedback == feedback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,session,const DeepCollectionEquality().hash(_messages),report,feedback);

@override
String toString() {
  return 'InterviewDetailModel(session: $session, messages: $messages, report: $report, feedback: $feedback)';
}


}

/// @nodoc
abstract mixin class _$InterviewDetailModelCopyWith<$Res> implements $InterviewDetailModelCopyWith<$Res> {
  factory _$InterviewDetailModelCopyWith(_InterviewDetailModel value, $Res Function(_InterviewDetailModel) _then) = __$InterviewDetailModelCopyWithImpl;
@override @useResult
$Res call({
 InterviewSessionModel session, List<InterviewMessageModel> messages, InterviewReportModel? report, SessionFeedbackModel? feedback
});


@override $InterviewSessionModelCopyWith<$Res> get session;@override $InterviewReportModelCopyWith<$Res>? get report;@override $SessionFeedbackModelCopyWith<$Res>? get feedback;

}
/// @nodoc
class __$InterviewDetailModelCopyWithImpl<$Res>
    implements _$InterviewDetailModelCopyWith<$Res> {
  __$InterviewDetailModelCopyWithImpl(this._self, this._then);

  final _InterviewDetailModel _self;
  final $Res Function(_InterviewDetailModel) _then;

/// Create a copy of InterviewDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? session = null,Object? messages = null,Object? report = freezed,Object? feedback = freezed,}) {
  return _then(_InterviewDetailModel(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as InterviewSessionModel,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<InterviewMessageModel>,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as InterviewReportModel?,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as SessionFeedbackModel?,
  ));
}

/// Create a copy of InterviewDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InterviewSessionModelCopyWith<$Res> get session {
  
  return $InterviewSessionModelCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of InterviewDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InterviewReportModelCopyWith<$Res>? get report {
    if (_self.report == null) {
    return null;
  }

  return $InterviewReportModelCopyWith<$Res>(_self.report!, (value) {
    return _then(_self.copyWith(report: value));
  });
}/// Create a copy of InterviewDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionFeedbackModelCopyWith<$Res>? get feedback {
    if (_self.feedback == null) {
    return null;
  }

  return $SessionFeedbackModelCopyWith<$Res>(_self.feedback!, (value) {
    return _then(_self.copyWith(feedback: value));
  });
}
}


/// @nodoc
mixin _$InterviewSummaryModel {

 String get id; String? get role; String get interviewType; int? get score; String? get passResult; DateTime get createdAt;
/// Create a copy of InterviewSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterviewSummaryModelCopyWith<InterviewSummaryModel> get copyWith => _$InterviewSummaryModelCopyWithImpl<InterviewSummaryModel>(this as InterviewSummaryModel, _$identity);

  /// Serializes this InterviewSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterviewSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.interviewType, interviewType) || other.interviewType == interviewType)&&(identical(other.score, score) || other.score == score)&&(identical(other.passResult, passResult) || other.passResult == passResult)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,role,interviewType,score,passResult,createdAt);

@override
String toString() {
  return 'InterviewSummaryModel(id: $id, role: $role, interviewType: $interviewType, score: $score, passResult: $passResult, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $InterviewSummaryModelCopyWith<$Res>  {
  factory $InterviewSummaryModelCopyWith(InterviewSummaryModel value, $Res Function(InterviewSummaryModel) _then) = _$InterviewSummaryModelCopyWithImpl;
@useResult
$Res call({
 String id, String? role, String interviewType, int? score, String? passResult, DateTime createdAt
});




}
/// @nodoc
class _$InterviewSummaryModelCopyWithImpl<$Res>
    implements $InterviewSummaryModelCopyWith<$Res> {
  _$InterviewSummaryModelCopyWithImpl(this._self, this._then);

  final InterviewSummaryModel _self;
  final $Res Function(InterviewSummaryModel) _then;

/// Create a copy of InterviewSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? role = freezed,Object? interviewType = null,Object? score = freezed,Object? passResult = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,interviewType: null == interviewType ? _self.interviewType : interviewType // ignore: cast_nullable_to_non_nullable
as String,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int?,passResult: freezed == passResult ? _self.passResult : passResult // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [InterviewSummaryModel].
extension InterviewSummaryModelPatterns on InterviewSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InterviewSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InterviewSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InterviewSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _InterviewSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InterviewSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _InterviewSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? role,  String interviewType,  int? score,  String? passResult,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InterviewSummaryModel() when $default != null:
return $default(_that.id,_that.role,_that.interviewType,_that.score,_that.passResult,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? role,  String interviewType,  int? score,  String? passResult,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _InterviewSummaryModel():
return $default(_that.id,_that.role,_that.interviewType,_that.score,_that.passResult,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? role,  String interviewType,  int? score,  String? passResult,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _InterviewSummaryModel() when $default != null:
return $default(_that.id,_that.role,_that.interviewType,_that.score,_that.passResult,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InterviewSummaryModel extends InterviewSummaryModel {
  const _InterviewSummaryModel({required this.id, this.role, required this.interviewType, this.score, this.passResult, required this.createdAt}): super._();
  factory _InterviewSummaryModel.fromJson(Map<String, dynamic> json) => _$InterviewSummaryModelFromJson(json);

@override final  String id;
@override final  String? role;
@override final  String interviewType;
@override final  int? score;
@override final  String? passResult;
@override final  DateTime createdAt;

/// Create a copy of InterviewSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterviewSummaryModelCopyWith<_InterviewSummaryModel> get copyWith => __$InterviewSummaryModelCopyWithImpl<_InterviewSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterviewSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InterviewSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.interviewType, interviewType) || other.interviewType == interviewType)&&(identical(other.score, score) || other.score == score)&&(identical(other.passResult, passResult) || other.passResult == passResult)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,role,interviewType,score,passResult,createdAt);

@override
String toString() {
  return 'InterviewSummaryModel(id: $id, role: $role, interviewType: $interviewType, score: $score, passResult: $passResult, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$InterviewSummaryModelCopyWith<$Res> implements $InterviewSummaryModelCopyWith<$Res> {
  factory _$InterviewSummaryModelCopyWith(_InterviewSummaryModel value, $Res Function(_InterviewSummaryModel) _then) = __$InterviewSummaryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? role, String interviewType, int? score, String? passResult, DateTime createdAt
});




}
/// @nodoc
class __$InterviewSummaryModelCopyWithImpl<$Res>
    implements _$InterviewSummaryModelCopyWith<$Res> {
  __$InterviewSummaryModelCopyWithImpl(this._self, this._then);

  final _InterviewSummaryModel _self;
  final $Res Function(_InterviewSummaryModel) _then;

/// Create a copy of InterviewSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? role = freezed,Object? interviewType = null,Object? score = freezed,Object? passResult = freezed,Object? createdAt = null,}) {
  return _then(_InterviewSummaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,interviewType: null == interviewType ? _self.interviewType : interviewType // ignore: cast_nullable_to_non_nullable
as String,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int?,passResult: freezed == passResult ? _self.passResult : passResult // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$InterviewHistoryPageModel {

 List<InterviewSummaryModel> get items; String? get nextCursor;
/// Create a copy of InterviewHistoryPageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterviewHistoryPageModelCopyWith<InterviewHistoryPageModel> get copyWith => _$InterviewHistoryPageModelCopyWithImpl<InterviewHistoryPageModel>(this as InterviewHistoryPageModel, _$identity);

  /// Serializes this InterviewHistoryPageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterviewHistoryPageModel&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextCursor);

@override
String toString() {
  return 'InterviewHistoryPageModel(items: $items, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class $InterviewHistoryPageModelCopyWith<$Res>  {
  factory $InterviewHistoryPageModelCopyWith(InterviewHistoryPageModel value, $Res Function(InterviewHistoryPageModel) _then) = _$InterviewHistoryPageModelCopyWithImpl;
@useResult
$Res call({
 List<InterviewSummaryModel> items, String? nextCursor
});




}
/// @nodoc
class _$InterviewHistoryPageModelCopyWithImpl<$Res>
    implements $InterviewHistoryPageModelCopyWith<$Res> {
  _$InterviewHistoryPageModelCopyWithImpl(this._self, this._then);

  final InterviewHistoryPageModel _self;
  final $Res Function(InterviewHistoryPageModel) _then;

/// Create a copy of InterviewHistoryPageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<InterviewSummaryModel>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InterviewHistoryPageModel].
extension InterviewHistoryPageModelPatterns on InterviewHistoryPageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InterviewHistoryPageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InterviewHistoryPageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InterviewHistoryPageModel value)  $default,){
final _that = this;
switch (_that) {
case _InterviewHistoryPageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InterviewHistoryPageModel value)?  $default,){
final _that = this;
switch (_that) {
case _InterviewHistoryPageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<InterviewSummaryModel> items,  String? nextCursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InterviewHistoryPageModel() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<InterviewSummaryModel> items,  String? nextCursor)  $default,) {final _that = this;
switch (_that) {
case _InterviewHistoryPageModel():
return $default(_that.items,_that.nextCursor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<InterviewSummaryModel> items,  String? nextCursor)?  $default,) {final _that = this;
switch (_that) {
case _InterviewHistoryPageModel() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InterviewHistoryPageModel extends InterviewHistoryPageModel {
  const _InterviewHistoryPageModel({final  List<InterviewSummaryModel> items = const <InterviewSummaryModel>[], this.nextCursor}): _items = items,super._();
  factory _InterviewHistoryPageModel.fromJson(Map<String, dynamic> json) => _$InterviewHistoryPageModelFromJson(json);

 final  List<InterviewSummaryModel> _items;
@override@JsonKey() List<InterviewSummaryModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextCursor;

/// Create a copy of InterviewHistoryPageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterviewHistoryPageModelCopyWith<_InterviewHistoryPageModel> get copyWith => __$InterviewHistoryPageModelCopyWithImpl<_InterviewHistoryPageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterviewHistoryPageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InterviewHistoryPageModel&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextCursor);

@override
String toString() {
  return 'InterviewHistoryPageModel(items: $items, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class _$InterviewHistoryPageModelCopyWith<$Res> implements $InterviewHistoryPageModelCopyWith<$Res> {
  factory _$InterviewHistoryPageModelCopyWith(_InterviewHistoryPageModel value, $Res Function(_InterviewHistoryPageModel) _then) = __$InterviewHistoryPageModelCopyWithImpl;
@override @useResult
$Res call({
 List<InterviewSummaryModel> items, String? nextCursor
});




}
/// @nodoc
class __$InterviewHistoryPageModelCopyWithImpl<$Res>
    implements _$InterviewHistoryPageModelCopyWith<$Res> {
  __$InterviewHistoryPageModelCopyWithImpl(this._self, this._then);

  final _InterviewHistoryPageModel _self;
  final $Res Function(_InterviewHistoryPageModel) _then;

/// Create a copy of InterviewHistoryPageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(_InterviewHistoryPageModel(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<InterviewSummaryModel>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
