import 'package:flutter/material.dart';
import 'package:leaflet_task/components/nav_item.dart';
import 'package:leaflet_task/core/constants/navigation_constant.dart';
import 'package:leaflet_task/core/constants/size_constant.dart';
import 'package:leaflet_task/core/extension/context_extension.dart';
import 'package:leaflet_task/core/manager/navigation/navigation_service.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.widthRate(Sizes.p50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: context.heightRate(Sizes.p20),
          ),
          Expanded(
            child: ListView(
              children: _getDrawerItem(context).map(
                (e) {
                  return ListTile(
                      leading: Icon(e.icons),
                      title: Text(e.title),
                      onTap: e.onTap);
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<NavItem> _getDrawerItem(BuildContext context) {
    return [
      NavItem('Map', Icons.map, () {
        NavigationService.instance.navigateToPage(NavigationConstant.map);
      }),
      NavItem('Bluetooth', Icons.bluetooth, () {
        NavigationService.instance.navigateToPage(NavigationConstant.blue);
      })
    ];
  }
}
