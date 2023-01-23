import 'dart:convert';

import 'package:assignment/category/presentation/manager/category/category_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/category.dart';

class CategoryCubit extends Cubit<CategoryState> {


  List<Category> categories = [];

  List<int> parentIds = [];

  CategoryCubit(super.initialState);

  Future<void> readJson() async {
    emit(LoadingJson());
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    categories = List<Category>.from(data['category'].map((item) => Category().fromMap(item)).toList());
    // print("Categories : ${categories.length}");
    emit(LoadedJson());
  }

 void loadParentCategory(){
    emit(LoadingParentCategory());
   // print("Categories : ${categories.length}");
   List<Category> parentCategories = [];
   parentCategories = List<Category>.from(categories.where((element) => element.parent == 0));
   emit(LoadedParentCategory(parentCategories: parentCategories));
   // print("parentCategories : ${parentCategories.length}");
 }

 void loadChildCategory(int parentId){
   emit(LoadingChildCategory());
   // print("Categories : ${categories.length}");
   List<Category> childCategories = [];
   childCategories = List<Category>.from(categories.where((element) => element.parent == parentId));
   emit(LoadedChildCategory(childCategories: childCategories));
 }

 bool checkChild(int parentId){
   bool x =  categories.any((element) => element.parent == parentId);
   return x;
 }



}