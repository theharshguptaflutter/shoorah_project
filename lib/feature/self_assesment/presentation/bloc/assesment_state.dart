part of 'assesment_bloc.dart';

@immutable
sealed class AssesmentState {}

final class AssesmentInitial extends AssesmentState {}

final class AssesmentLoading extends AssesmentState {}

final class AssesmentLoaded extends AssesmentState {
  final List<CategoryModel> categoryList;

  AssesmentLoaded(this.categoryList);
}

final class AssesmentErrorState extends AssesmentState {
  final String message;

  AssesmentErrorState(this.message);
}