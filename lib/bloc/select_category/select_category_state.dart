part of 'select_category_bloc.dart';

class SelectCategoryState extends Equatable {
  final String categoryId;
  const SelectCategoryState({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}
