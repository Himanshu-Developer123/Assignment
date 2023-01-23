
import 'package:equatable/equatable.dart';

import '../../../data/models/category.dart';

abstract class CategoryState extends Equatable{
  const CategoryState();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}


class InitialState extends CategoryState {
  const InitialState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingCategoryState extends CategoryState {
  const LoadingCategoryState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedCategoryState extends CategoryState {
  const LoadedCategoryState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingParentCategory extends CategoryState {
  const LoadingParentCategory();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoadedParentCategory extends CategoryState {
  List<Category> parentCategories = [];
  LoadedParentCategory({required this.parentCategories});
  @override
  // TODO: implement props
  List<Object?> get props => [parentCategories];
}

class LoadingChildCategory extends CategoryState {
  const LoadingChildCategory();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoadedChildCategory extends CategoryState {
  List<Category> childCategories = [];
  LoadedChildCategory({required this.childCategories});
  @override
  // TODO: implement props
  List<Object?> get props => [childCategories];

}

class LoadingJson extends CategoryState {
  const LoadingJson();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoadedJson extends CategoryState {
  const LoadedJson();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
