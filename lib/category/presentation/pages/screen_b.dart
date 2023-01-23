import 'package:assignment/category/presentation/pages/screen_a.dart';
import 'package:assignment/category/presentation/pages/screen_c.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/category.dart';
import '../manager/category/category_cubit.dart';
import '../manager/category/category_state.dart';

class ScreenB extends StatefulWidget {
  int parentId;
  ScreenB({required this.parentId});
  ScreenBState createState() => ScreenBState();
}

class ScreenBState extends State<ScreenB>{

  late CategoryCubit categoryCubit;

  @override
  void initState(){
    super.initState();
    categoryCubit = context.read<CategoryCubit>();
    categoryCubit.loadChildCategory(widget.parentId);
    categoryCubit.parentIds.forEach((element) {
      print("id xxxxxxx: $element");
    });
    // categoryCubit.loadParentCategory();
  }

  @override
  void dispose(){
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if(categoryCubit.parentIds.length > 1){
      print('AAAAAAA');
      categoryCubit.parentIds.removeLast();
      categoryCubit.loadChildCategory(categoryCubit.parentIds[categoryCubit.parentIds.length - 1]);

      categoryCubit.parentIds.forEach((element) {
        print("id 121212 : $element");
      });

    }
    else{
      print('CCCCCCC');
      categoryCubit.parentIds.clear();
      categoryCubit.loadParentCategory();
    }


    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ScreenA()),ModalRoute.withName('/'),);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Categories'),),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height:  MediaQuery.of(context).size.height,
          child: BlocBuilder<CategoryCubit,CategoryState>(
            builder: (context,state){

              if(state is LoadingChildCategory){
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    color: Colors.pink,
                  ),
                );
              }
              
              if(state is LoadedChildCategory){
                List<Category> parentCategories = state.childCategories;
                return ListView.builder(
                    itemCount: parentCategories.length,
                    itemBuilder: (context,index){

                      bool isChildAvailable = categoryCubit.checkChild(parentCategories[index].id!);

                      return InkWell(
                        onTap: (){
                          if(isChildAvailable){
                            categoryCubit.parentIds.add(parentCategories[index].id!);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenB(parentId: parentCategories[index].id!,)),);
                          }else{
                            categoryCubit.parentIds.add(parentCategories[index].id!);
                            // categoryCubit.parentIds.add(widget.parentId);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenC()),);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left:10,right: 10,top: 10),
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          color: Colors.blue,
                          child: Center(
                              child: Text(parentCategories[index].name!,style: TextStyle(fontSize: 32,color: Colors.white),)
                          ),
                        ),
                      );
                    }
                );
              }

              else{
                return Container();
              }

            },
          ),
        ),
      ),
    );



  }

}