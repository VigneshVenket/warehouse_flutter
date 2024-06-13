import 'package:flutter/material.dart';
import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/models/category.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_style_1.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_style_2.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_style_3.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_style_4.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_style_5.dart';

import '../constants/app_config.dart';
import '../tweaks/app_localization.dart';

class ChildCategoriesScreen extends StatefulWidget {
  final List<Category> categories;
  final List<Category> allCategories;
  final Function(Widget widget) navigateToNext;
  const ChildCategoriesScreen(this.categories, this.allCategories, this.navigateToNext, {Key? key}) : super(key: key);

  @override
  _ChildCategoriesScreenState createState() => _ChildCategoriesScreenState();
}

class _ChildCategoriesScreenState extends State<ChildCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return AppConfig.APP_BAR_COLOR ==2 ?
    Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Colors.white,
      appBar:
      AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color:AppConfig.APP_BAR_COLOR == 2 ?
          Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black :
          Colors.white,
        ),
        // iconTheme: Theme.of(context).iconTheme,
        backgroundColor:AppConfig.APP_BAR_COLOR == 2 ?
        Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
        Colors.white,
        // backgroundColor: Theme.of(context).cardColor,
        title: Text(AppLocalizations.of(context)!.translate("Categories")!,
          style:TextStyle(
            color:AppConfig.APP_BAR_COLOR == 2 ?
            Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black :
            Colors.white,
            //  Theme.of(context).textTheme.titleLarge),
          ),
        ),
        elevation: 0.0,
      ),
      body: getDefaultCategory(),
    ):
    Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Colors.white,
    appBar:
    AppBar(
    centerTitle: true,
    iconTheme: IconThemeData(
    color:AppConfig.APP_BAR_COLOR == 1 ?
    Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
    Colors.white,
    ),
    // iconTheme: Theme.of(context).iconTheme,
    backgroundColor:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
      // backgroundColor: Theme.of(context).cardColor,
    title: Text(AppLocalizations.of(context)!.translate("Categories")!,
    style:TextStyle(
    color:AppConfig.APP_BAR_COLOR == 1 ?
    Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white :
    Colors.white,
    //  Theme.of(context).textTheme.titleLarge),
    ),
    ),
    elevation: 0.0,
    ),
    );
  }

  Widget getDefaultCategory() {
    switch (int.parse(AppData.settingsResponse
        !.getKeyValue(SettingsResponse.CATEGORY_STYLE))) {
      case 1:
        return CategoryWidgetStyle1(widget.allCategories, widget.categories, widget.navigateToNext);
      case 2:
        return CategoryWidgetStyle2(widget.allCategories, widget.categories, widget.navigateToNext);
      case 3:
        return CategoryWidgetStyle3(widget.allCategories, widget.categories, widget.navigateToNext);
      case 4:
        return CategoryWidgetStyle4(widget.allCategories, widget.categories, widget.navigateToNext);
      case 5:
        return CategoryWidgetStyle5(widget.allCategories, widget.categories, widget.navigateToNext);
      case 6:
        return CategoryWidgetStyle1(widget.allCategories, widget.categories, widget.navigateToNext);
      default:
        return CategoryWidgetStyle1(widget.allCategories, widget.categories, widget.navigateToNext);
    }
  }
}
