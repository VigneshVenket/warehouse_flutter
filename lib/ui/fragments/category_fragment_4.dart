import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/models/category.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_style_4.dart';
import 'package:flutter_kundol/ui/widgets/home_app_bar.dart';


class CategoryFragment4 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;

  const CategoryFragment4(this.navigateToNext, this.openDrawer);

  @override
  _CategoryFragment4State createState() => _CategoryFragment4State();
}

class _CategoryFragment4State extends State<CategoryFragment4> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0), // here the desired height
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).cardColor,
          )
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HomeAppBar(widget.navigateToNext, widget.openDrawer),
          const SizedBox(height: 5,),
          Expanded(
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesLoaded) {
                  return CategoryWidgetStyle4(state.categoriesResponse.data!, getParentCategories(state.categoriesResponse.data!), widget.navigateToNext);
                } else if (state is CategoriesError) {
                  return Text(state.error);
                } else {
                  return Center(
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
