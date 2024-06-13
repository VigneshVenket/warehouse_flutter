import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/models/category.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_style_2.dart';
import 'package:flutter_kundol/ui/widgets/home_app_bar.dart';


class CategoryFragment2 extends StatefulWidget {
  Function(Widget widget) navigateToNext;
  final Function() openDrawer;

  CategoryFragment2(this.navigateToNext, this.openDrawer);

  @override
  _CategoryFragment2State createState() => _CategoryFragment2State();
}

class _CategoryFragment2State extends State<CategoryFragment2> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness ==
          Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255,1),
      appBar: AppBar(
        centerTitle: true,

        elevation: 0.0,
        title: Text("Category Products",
          style: TextStyle(
            color:Theme.of(context).brightness ==
                Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
            fontSize: 18,
            fontWeight: FontWeight.w900
        ),),
         leading: InkWell(
           onTap: (){
             Navigator.pop(context);
           },
         child:  Icon(Icons.arrow_back_ios_new_rounded,
         color: Theme.of(context).brightness == Brightness.dark
         ? Color.fromRGBO(255, 255, 255, 1)
             : Color.fromRGBO(18, 18, 18, 1),
         ),),
        backgroundColor: Theme.of(context).brightness ==
            Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // HomeAppBar(widget.navigateToNext, widget.openDrawer),
          Expanded(
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesLoaded) {
                  return CategoryWidgetStyle2(state.categoriesResponse.data!, getParentCategories(state.categoriesResponse.data!), widget.navigateToNext);
                } else if (state is CategoriesError) {
                  return Text(state.error);
                } else {
                  return  Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  List<Category> getParentCategories(List<Category> data) {
    List<Category> tempCategories = [];
    for (int i=0; i<data.length; i++){
      if (data[i].parent == null){
        tempCategories.add(data[i]);
      }
    }
    return tempCategories;
  }

  List<Category> getChildCategories(List<Category> data, int id) {
    List<Category> tempCategories = [];
    for (int i=0; i<data.length; i++){
      if (data[i].parent == id){
        tempCategories.add(data[i]);
      }
    }
    return tempCategories;
  }

}
