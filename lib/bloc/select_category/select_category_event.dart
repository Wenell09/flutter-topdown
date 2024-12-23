part of 'select_category_bloc.dart';

sealed class SelectCategoryEvent extends Equatable {}

class SelectCategory extends SelectCategoryEvent {
  final String categoryId;
  SelectCategory({required this.categoryId});
  @override
  List<Object?> get props => [categoryId];
}
