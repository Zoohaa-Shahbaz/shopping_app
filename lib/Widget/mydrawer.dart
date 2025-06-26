import 'package:flutter/material.dart';
import 'package:shopping_app/utils/appconstant.dart';

import '../models/UserMode.dart';

class MyDrawer extends StatefulWidget {
  final String ? UserName;

  const MyDrawer({super.key, this.UserName});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Drawer(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Wrap(
            runSpacing: 10,
            children: [
              ListTile(
                title: Text(widget.UserName.toString()),
                subtitle: Text("Version 1.0.1"),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppContant.primaryColor,
                  child: Text("W"),
                ),
              ),
              Divider(
                indent: 10.0,
                endIndent: 10.0,
                thickness: 1.5,
                color: Colors.grey,
              ),

      ListTile(
        titleAlignment: ListTileTitleAlignment.center,
          title: Text("Home"),

          leading: Icon(Icons.home),
        trailing: Icon(Icons.arrow_forward),
          
      ),

              ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Products"),

                leading: Icon(Icons.production_quantity_limits),
                trailing: Icon(Icons.arrow_forward),

              ),
              ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Orders"),

                leading: Icon(Icons.shopping_bag),
                trailing: Icon(Icons.arrow_forward),

              ),
              ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Contact"),

                leading: Icon(Icons.help_outline),
                trailing: Icon(Icons.arrow_forward),

              ),
              ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Home"),

                leading: Icon(Icons.logout),
                trailing: Icon(Icons.arrow_forward),

              )
            ]),


    ));
  }
}
