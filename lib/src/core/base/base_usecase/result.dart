import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@Freezed(toJson: false, fromJson: false)
sealed class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(Exception exception) = Failure<T>;
}

extension ResultExtension<T> on Result<T> {
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get data => switch (this) {
        Success(:final data) => data,
        Failure() => null,
      };

  Exception? get exception => switch (this) {
        Success() => null,
        Failure(:final exception) => exception,
      };

  R when<R>({
    required R Function(T data) success,
    required R Function(Exception exception) failure,
  }) {
    return switch (this) {
      Success(:final data) => success(data),
      Failure(:final exception) => failure(exception),
    };
  }

  R maybeWhen<R>({
    R Function(T data)? success,
    R Function(Exception exception)? failure,
    required R Function() orElse,
  }) {
    return switch (this) {
      Success(:final data) => success?.call(data) ?? orElse(),
      Failure(:final exception) => failure?.call(exception) ?? orElse(),
    };
  }
}
