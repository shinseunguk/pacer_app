import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/interview_message.dart';
import '../../domain/entities/interview_report.dart';
import '../../domain/entities/interview_session.dart';

part 'interview_models.freezed.dart';
part 'interview_models.g.dart';

@freezed
abstract class ProgressModel with _$ProgressModel {
  const ProgressModel._();

  const factory ProgressModel({
    @Default(0) int current,
    @Default(0) int total,
  }) = _ProgressModel;

  factory ProgressModel.fromJson(Map<String, dynamic> json) =>
      _$ProgressModelFromJson(json);

  InterviewProgress toEntity() =>
      InterviewProgress(current: current, total: total);
}

@freezed
abstract class MessageFeedbackModel with _$MessageFeedbackModel {
  const MessageFeedbackModel._();

  const factory MessageFeedbackModel({String? feedback, String? modelAnswer}) =
      _MessageFeedbackModel;

  factory MessageFeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$MessageFeedbackModelFromJson(json);

  MessageFeedback toEntity() =>
      MessageFeedback(feedback: feedback, modelAnswer: modelAnswer);
}

@freezed
abstract class InterviewMessageModel with _$InterviewMessageModel {
  const InterviewMessageModel._();

  const factory InterviewMessageModel({
    required String messageId,
    required int seq,
    required String type,
    String? content,
    String? parentId,
    MessageFeedbackModel? feedback,
  }) = _InterviewMessageModel;

  factory InterviewMessageModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewMessageModelFromJson(json);

  InterviewMessage toEntity() => InterviewMessage(
    messageId: messageId,
    seq: seq,
    type: MessageType.fromValue(type),
    content: content,
    parentId: parentId,
    feedback: feedback?.toEntity(),
  );
}

/// `POST /interviews`
@freezed
abstract class CreatedInterviewModel with _$CreatedInterviewModel {
  const CreatedInterviewModel._();

  const factory CreatedInterviewModel({
    required String sessionId,
    required String status,
    required ProgressModel progress,
    required InterviewMessageModel firstQuestion,
  }) = _CreatedInterviewModel;

  factory CreatedInterviewModel.fromJson(Map<String, dynamic> json) =>
      _$CreatedInterviewModelFromJson(json);

  CreatedInterview toEntity() => CreatedInterview(
    sessionId: sessionId,
    status: SessionStatus.fromValue(status),
    progress: progress.toEntity(),
    firstQuestion: firstQuestion.toEntity(),
  );
}

/// `POST /interviews/{id}/skip`
@freezed
abstract class SkipResultModel with _$SkipResultModel {
  const SkipResultModel._();

  const factory SkipResultModel({
    InterviewMessageModel? next,
    required ProgressModel progress,
    @Default(false) bool done,
  }) = _SkipResultModel;

  factory SkipResultModel.fromJson(Map<String, dynamic> json) =>
      _$SkipResultModelFromJson(json);

  SkipResult toEntity() => SkipResult(
    next: next?.toEntity(),
    progress: progress.toEntity(),
    done: done,
  );
}

/// `POST /interviews/{id}/resume`
@freezed
abstract class ResumedInterviewModel with _$ResumedInterviewModel {
  const ResumedInterviewModel._();

  const factory ResumedInterviewModel({
    required String status,
    required ProgressModel progress,
    @Default(<InterviewMessageModel>[]) List<InterviewMessageModel> messages,
  }) = _ResumedInterviewModel;

  factory ResumedInterviewModel.fromJson(Map<String, dynamic> json) =>
      _$ResumedInterviewModelFromJson(json);

  ResumedInterview toEntity() => ResumedInterview(
    status: SessionStatus.fromValue(status),
    progress: progress.toEntity(),
    messages: messages.map((message) => message.toEntity()).toList(),
  );
}

@freezed
abstract class CriterionScoreModel with _$CriterionScoreModel {
  const CriterionScoreModel._();

  const factory CriterionScoreModel({
    required String criterion,
    required int score,
    @Default(0) num weight,
  }) = _CriterionScoreModel;

  factory CriterionScoreModel.fromJson(Map<String, dynamic> json) =>
      _$CriterionScoreModelFromJson(json);

  CriterionScore toEntity() => CriterionScore(
    criterion: criterion,
    score: score,
    weight: weight.toDouble(),
  );
}

@freezed
abstract class InterviewReportModel with _$InterviewReportModel {
  const InterviewReportModel._();

  const factory InterviewReportModel({
    required int overallScore,
    @Default(true) bool showScore,
    required String passResult,
    @Default('') String passReason,
    @Default('general') String weightPreset,
    @Default(<CriterionScoreModel>[]) List<CriterionScoreModel> scores,
  }) = _InterviewReportModel;

  factory InterviewReportModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewReportModelFromJson(json);

  InterviewReport toEntity() => InterviewReport(
    overallScore: overallScore,
    showScore: showScore,
    passResult: passResult,
    passReason: passReason,
    weightPreset: weightPreset,
    scores: scores.map((score) => score.toEntity()).toList(),
  );
}

/// `POST /interviews/{id}/complete`
@freezed
abstract class CompleteInterviewModel with _$CompleteInterviewModel {
  const factory CompleteInterviewModel({
    required String sessionId,
    required String status,
    required InterviewReportModel report,
  }) = _CompleteInterviewModel;

  factory CompleteInterviewModel.fromJson(Map<String, dynamic> json) =>
      _$CompleteInterviewModelFromJson(json);
}

@freezed
abstract class InterviewSessionModel with _$InterviewSessionModel {
  const factory InterviewSessionModel({
    required String id,
    required String interviewType,
    required String difficulty,
    required String status,
    String? role,
    required ProgressModel progress,
    required DateTime createdAt,
  }) = _InterviewSessionModel;

  factory InterviewSessionModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewSessionModelFromJson(json);
}

@freezed
abstract class SessionFeedbackModel with _$SessionFeedbackModel {
  const SessionFeedbackModel._();

  const factory SessionFeedbackModel({
    required String rating,
    String? comment,
  }) = _SessionFeedbackModel;

  factory SessionFeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$SessionFeedbackModelFromJson(json);

  SessionFeedback? toEntity() {
    final parsed = FeedbackRating.fromValue(rating);
    return parsed == null
        ? null
        : SessionFeedback(rating: parsed, comment: comment);
  }
}

/// `GET /interviews/{id}`
@freezed
abstract class InterviewDetailModel with _$InterviewDetailModel {
  const InterviewDetailModel._();

  const factory InterviewDetailModel({
    required InterviewSessionModel session,
    @Default(<InterviewMessageModel>[]) List<InterviewMessageModel> messages,
    InterviewReportModel? report,
    SessionFeedbackModel? feedback,
  }) = _InterviewDetailModel;

  factory InterviewDetailModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewDetailModelFromJson(json);

  InterviewDetail toEntity() => InterviewDetail(
    id: session.id,
    interviewType: session.interviewType,
    difficulty: session.difficulty,
    status: SessionStatus.fromValue(session.status),
    role: session.role,
    progress: session.progress.toEntity(),
    createdAt: session.createdAt,
    messages: messages.map((message) => message.toEntity()).toList(),
    report: report?.toEntity(),
    feedback: feedback?.toEntity(),
  );
}

@freezed
abstract class InterviewSummaryModel with _$InterviewSummaryModel {
  const InterviewSummaryModel._();

  const factory InterviewSummaryModel({
    required String id,
    String? role,
    required String interviewType,
    int? score,
    String? passResult,
    required DateTime createdAt,
  }) = _InterviewSummaryModel;

  factory InterviewSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewSummaryModelFromJson(json);

  InterviewSummary toEntity() => InterviewSummary(
    id: id,
    role: role,
    interviewType: interviewType,
    score: score,
    passResult: passResult,
    createdAt: createdAt,
  );
}

/// `GET /interviews`
@freezed
abstract class InterviewHistoryPageModel with _$InterviewHistoryPageModel {
  const InterviewHistoryPageModel._();

  const factory InterviewHistoryPageModel({
    @Default(<InterviewSummaryModel>[]) List<InterviewSummaryModel> items,
    String? nextCursor,
  }) = _InterviewHistoryPageModel;

  factory InterviewHistoryPageModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewHistoryPageModelFromJson(json);

  InterviewHistoryPage toEntity() => InterviewHistoryPage(
    items: items.map((item) => item.toEntity()).toList(),
    nextCursor: nextCursor,
  );
}
