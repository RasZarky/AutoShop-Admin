import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:hostel_finder_admin/constants.dart';


class ManagerViewShops extends StatefulWidget {
  final String id;
  const ManagerViewShops({super.key, required this.id});

  @override
  State<ManagerViewShops> createState() => _ManagerViewShopsState(id: id);
}

class _ManagerViewShopsState extends State<ManagerViewShops> {

  final String id;
  _ManagerViewShopsState({ required this.id});

  Query dbRef = FirebaseDatabase.instance.ref().child('shops');
  
  Widget listItem( {required Map shops}){
    return shops['manager'] == id ? Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),

      color: Colors.orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Name: '${shops['name']}'",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SizedBox(height: 2,),
          Text(
            "Category: '${shops['category']}'",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SizedBox(height: 2,),
          Text(
            "Location: '${shops['location']}'",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SizedBox(height: 2,),
          Text(
            "Price: '${shops['price']}'",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){

                  FirebaseDatabase.instance.ref().child('shops').child(shops['key']).remove();
                  var snackBar = const SnackBar(
                    content: Text( "Shop Deleted",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25,
                      backgroundColor: Colors.red),
                ),
              )
            ],
          )
        ],
      ),
    ) : Container();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: Center(
                child: const Text(
                  "All Shops",
                ),
              ),
            ),
          body:  SizedBox(
            width: double.infinity,
            child: Container(
              child: FirebaseAnimatedList(
                query: dbRef,
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

                  Map shops = snapshot.value as Map;
                  shops['key'] = snapshot.key;

                  return  listItem(shops: shops);
                },

              ),
            )
          ),
          )

    );
  }
}


