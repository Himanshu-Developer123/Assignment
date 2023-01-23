import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/category/category_cubit.dart';

class ScreenC extends StatefulWidget {
  ScreenCState createState() => ScreenCState();
}

class ScreenCState extends State<ScreenC>{

  late CategoryCubit categoryCubit;

  // Future<bool> _onWillPop() async {
  //   if(categoryCubit.parentIds.isNotEmpty){
  //     categoryCubit.loadChildCategory(categoryCubit.parentIds[categoryCubit.parentIds.length - 1]);
  //     categoryCubit.parentIds.forEach((element) {
  //       print("id : $element");
  //     });
  //     categoryCubit.parentIds.removeLast();
  //   }else{
  //     categoryCubit.loadParentCategory();
  //   }
  //
  //
  //   // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ScreenA()),ModalRoute.withName('/'),);
  //   return true;
  // }

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
  void initState(){
    categoryCubit = context.read<CategoryCubit>();
    categoryCubit.parentIds.forEach((element) {
      print("id : $element");
    });
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
      body: WillPopScope(
          onWillPop: _onWillPop,
          child: Container()),
    );
  }

}