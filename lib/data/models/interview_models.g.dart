// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProgressModel _$ProgressModelFromJson(Map<String, dynamic> json) =>
    _ProgressModel(
      current: (json['current'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ProgressModelToJson(_ProgressModel instance) =>
    <String, dynamic>{'current': instance.current, 'total': instance.total};

_MessageFeedbackModel _$MessageFeedbackModelFromJson(
  Map<String, dynamic> json,
) => _MessageFeedbackModel(
  feedback: json['feedback'] as String?,
  modelAnswer: json['modelAnswer'] as String?,
);

Map<String, dynamic> _$MessageFeedbackModelToJson(
  _MessageFeedbackModel instance,
) => <String, dynamic>{
  'feedback': instance.feedback,
  'modelAnswer': instance.modelAnswer,
};

_InterviewMessageModel _$InterviewMessageModelFromJson(
  Map<String, dynamic> json,
) => _InterviewMessageModel(
  messageId: json['messageId'] as String,
  seq: (json['seq'] as num).toInt(),
  type: json['type'] as String,
  content: json['content'] as String?,
  parentId: json['parentId'] as String?,
  feedback: json['feedback'] == null
      ? null
      : MessageFeedbackModel.fromJson(json['feedback'] as Map<String, dynamic>),
);

Map<String, dynamic> _$InterviewMessageModelToJson(
  _InterviewMessageModel instance,
) => <String, dynamic>{
  'messageId': instance.messageId,
  'seq': instance.seq,
  'type': instance.type,
  'content': instance.content,
  'parentId': instance.parentId,
  'feedback': instance.feedback,
};

_CreatedInterviewModel _$CreatedInterviewModelFromJson(
  Map<String, dynamic> json,
) => _CreatedInterviewModel(
  sessionId: json['sessionId'] as String,
  status: json['status'] as String,
  progress: ProgressModel.fromJson(json['progress'] as Map<String, dynamic>),
  firstQuestion: InterviewMessageModel.fromJson(
    json['firstQuestion'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$CreatedInterviewModelToJson(
  _CreatedInterviewModel instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'status': instance.status,
  'progress': instance.progress,
  'firstQuestion': instance.firstQuestion,
};

_SkipResultModel _$SkipResultModelFromJson(
  Map<String, dynamic> json,
) => _SkipResultModel(
  next: json['next'] == null
      ? null
      : InterviewMessageModel.fromJson(json['next'] as Map<String, dynamic>),
  progress: ProgressModel.fromJson(json['progress'] as Map<String, dynamic>),
  done: json['done'] as bool? ?? false,
);

Map<String, dynamic> _$SkipResultModelToJson(_SkipResultModel instance) =>
    <String, dynamic>{
      'next': instance.next,
      'progress': instance.progress,
      'done': instance.done,
    };

_ResumedInterviewModel _$ResumedInterviewModelFromJson(
  Map<String, dynamic> json,
) => _ResumedInterviewModel(
  status: json['status'] as String,
  progress: ProgressModel.fromJson(json['progress'] as Map<String, dynamic>),
  messages:
      (json['messages'] as List<dynamic>?)
          ?.map(
            (e) => InterviewMessageModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <InterviewMessageModel>[],
);

Map<String, dynamic> _$ResumedInterviewModelToJson(
  _ResumedInterviewModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'progress': instance.progress,
  'messages': instance.messages,
};

_CriterionScoreModel _$CriterionScoreModelFromJson(Map<String, dynamic> json) =>
    _CriterionScoreModel(
      criterion: json['criterion'] as String,
      score: (json['score'] as num).toInt(),
      weight: json['weight'] as num? ?? 0,
    );

Map<String, dynamic> _$CriterionScoreModelToJson(
  _CriterionScoreModel instance,
) => <String, dynamic>{
  'criterion': instance.criterion,
  'score': instance.score,
  'weight': instance.weight,
};

_InterviewReportModel _$InterviewReportModelFromJson(
  Map<String, dynamic> json,
) => _InterviewReportModel(
  overallScore: (json['overallScore'] as num).toInt(),
  showScore: json['showScore'] as bool? ?? true,
  passResult: json['passResult'] as String,
  passReason: json['passReason'] as String? ?? '',
  weightPreset: json['weightPreset'] as String? ?? 'general',
  scores:
      (json['scores'] as List<dynamic>?)
          ?.map((e) => CriterionScoreModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <CriterionScoreModel>[],
);

Map<String, dynamic> _$InterviewReportModelToJson(
  _InterviewReportModel instance,
) => <String, dynamic>{
  'overallScore': instance.overallScore,
  'showScore': instance.showScore,
  'passResult': instance.passResult,
  'passReason': instance.passReason,
  'weightPreset': instance.weightPreset,
  'scores': instance.scores,
};

_CompleteInterviewModel _$CompleteInterviewModelFromJson(
  Map<String, dynamic> json,
) => _CompleteInterviewModel(
  sessionId: json['sessionId'] as String,
  status: json['status'] as String,
  report: InterviewReportModel.fromJson(json['report'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CompleteInterviewModelToJson(
  _CompleteInterviewModel instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'status': instance.status,
  'report': instance.report,
};

_InterviewSessionModel _$InterviewSessionModelFromJson(
  Map<String, dynamic> json,
) => _InterviewSessionModel(
  id: json['id'] as String,
  interviewType: json['interviewType'] as String,
  difficulty: json['difficulty'] as String,
  status: json['status'] as String,
  role: json['role'] as String?,
  progress: ProgressModel.fromJson(json['progress'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$InterviewSessionModelToJson(
  _InterviewSessionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'interviewType': instance.interviewType,
  'difficulty': instance.difficulty,
  'status': instance.status,
  'role': instance.role,
  'progress': instance.progress,
  'createdAt': instance.createdAt.toIso8601String(),
};

_SessionFeedbackModel _$SessionFeedbackModelFromJson(
  Map<String, dynamic> json,
) => _SessionFeedbackModel(
  rating: json['rating'] as String,
  comment: json['comment'] as String?,
);

Map<String, dynamic> _$SessionFeedbackModelToJson(
  _SessionFeedbackModel instance,
) => <String, dynamic>{'rating': instance.rating, 'comment': instance.comment};

_InterviewDetailModel _$InterviewDetailModelFromJson(
  Map<String, dynamic> json,
) => _InterviewDetailModel(
  session: InterviewSessionModel.fromJson(
    json['session'] as Map<String, dynamic>,
  ),
  messages:
      (json['messages'] as List<dynamic>?)
          ?.map(
            (e) => InterviewMessageModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <InterviewMessageModel>[],
  report: json['report'] == null
      ? null
      : InterviewReportModel.fromJson(json['report'] as Map<String, dynamic>),
  feedback: json['feedback'] == null
      ? null
      : SessionFeedbackModel.fromJson(json['feedback'] as Map<String, dynamic>),
);

Map<String, dynamic> _$InterviewDetailModelToJson(
  _InterviewDetailModel instance,
) => <String, dynamic>{
  'session': instance.session,
  'messages': instance.messages,
  'report': instance.report,
  'feedback': instance.feedback,
};

_InterviewSummaryModel _$InterviewSummaryModelFromJson(
  Map<String, dynamic> json,
) => _InterviewSummaryModel(
  id: json['id'] as String,
  role: json['role'] as String?,
  interviewType: json['interviewType'] as String,
  status: json['status'] as String? ?? 'in_progress',
  score: (json['score'] as num?)?.toInt(),
  passResult: json['passResult'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$InterviewSummaryModelToJson(
  _InterviewSummaryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'role': instance.role,
  'interviewType': instance.interviewType,
  'status': instance.status,
  'score': instance.score,
  'passResult': instance.passResult,
  'createdAt': instance.createdAt.toIso8601String(),
};

_InterviewHistoryPageModel _$InterviewHistoryPageModelFromJson(
  Map<String, dynamic> json,
) => _InterviewHistoryPageModel(
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) => InterviewSummaryModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <InterviewSummaryModel>[],
  nextCursor: json['nextCursor'] as String?,
);

Map<String, dynamic> _$InterviewHistoryPageModelToJson(
  _InterviewHistoryPageModel instance,
) => <String, dynamic>{
  'items': instance.items,
  'nextCursor': instance.nextCursor,
};
