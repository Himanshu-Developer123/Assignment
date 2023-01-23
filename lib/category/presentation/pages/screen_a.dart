import 'package:assignment/category/data/models/category.dart';
import 'package:assignment/category/presentation/manager/category/category_cubit.dart';
import 'package:assignment/category/presentation/pages/screen_b.dart';
import 'package:assignment/category/presentation/pages/screen_c.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/category/category_state.dart';

class ScreenA extends StatefulWidget {
  ScreenAState createState() => ScreenAState();
}

class ScreenAState extends State<ScreenA> with TickerProviderStateMixin{


  late CategoryCubit categoryCubit;

  @override
  void initState(){
    super.initState();
    categoryCubit = context.read<CategoryCubit>();
    categoryCubit.readJson();
    // categoryCubit.loadParentCategory();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Categories'),),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height:  MediaQuery.of(context).size.height,
        child: BlocBuilder<CategoryCubit,CategoryState>(
          builder: (context,state){
            print("State : ${state}");
            if(state is LoadingJson){
              return Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  color: Colors.pink,
                ),
              );
            }
            if(state is LoadedJson){
              categoryCubit.loadParentCategory();
              return Container();
            }
            if(state is LoadingParentCategory){
              return Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  color: Colors.pink,
                ),
              );
            }
            if(state is LoadedParentCategory){
              List<Category> parentCategories = state.parentCategories;
              return ListView.builder(
                  itemCount: parentCategories.length,
                  itemBuilder: (context,index){
                    /// Slide Right to Left Animation
                    // late final AnimationController _rightimageController =
                    // AnimationController(
                    //   duration: const Duration(seconds: 1),
                    //   vsync: this,
                    // );
                    // late final Animation<Offset> _rightimageAnimation =
                    // Tween<Offset>(
                    //   begin: Offset((index + 1).toDouble(), 0),
                    //   end: const Offset(0, 0),
                    // ).animate(CurvedAnimation(
                    //   parent: _rightimageController,
                    //   // curve: Curves.fastLinearToSlowEaseIn,
                    //   curve: Curves.easeOutCubic,
                    // ));
                    //
                    // _rightimageController.forward();

                    bool isChildAvailable = categoryCubit.checkChild(parentCategories[index].id!);
                    return InkWell(
                      onTap: (){
                        if(isChildAvailable){
                          categoryCubit.parentIds.add(parentCategories[index].id!);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenB(parentId: parentCategories[index].id!,)),);
                        }else{
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
    );
  }
  
}