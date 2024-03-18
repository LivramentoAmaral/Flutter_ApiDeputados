import 'package:equatable/equatable.dart';
import 'package:flutter_deputyapp/src/models/deputy_model.dart';

class DeputyState extends Equatable {
  final List<DeputyModel> deputies;
  final bool loading;
  final String error;

  const DeputyState({
    required this.deputies,
    required this.loading,
    required this.error,
  });

  factory DeputyState.initial() => const DeputyState(
        deputies: [],
        loading: false,
        error: '',
      );

  DeputyState copyWith({
    List<DeputyModel>? deputies,
    bool? loading,
    String? error,
  }) {
    return DeputyState(
      deputies: deputies ?? this.deputies,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [deputies, loading, error];
}
