import 'dart:async';

import 'package:erb_mobo/common/common_widgets/commomn_app_bar.dart';
import 'package:erb_mobo/ui/home/widgets/app_drawer/app_drawer.dart';
import 'package:erb_mobo/ui/my_profile/widgets/display_image_widget.dart';
import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({ Key? key }) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).primaryColor,
       appBar:commonAppBar(context: context,title:'my Profile'),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 10,
          ),
          // const Center(
          //     child: Padding(
          //         padding: EdgeInsets.only(bottom: 20),
          //         child: Text(
          //           'Edit Profile',
          //           style: TextStyle(
          //             fontSize: 30,
          //             fontWeight: FontWeight.w700,
          //             color: Color.fromRGBO(64, 105, 225, 1),
          //           ),
          //         ))),
          InkWell(
              onTap: () {
                // navigateSecondPage(EditImagePage());
              },
              child: DisplayImage(
                imagePath: 'https://www.diethelmtravel.com/wp-content/uploads/2016/04/bill-gates-wealthiest-person.jpg',
                onPressed: () {},
              )),
            SizedBox(height: 25,),
          buildUserInfoDisplay('mohammad al lababidi', 'Name', Container()),
          buildUserInfoDisplay('0937777777', 'Phone', Container()),
          buildUserInfoDisplay('test@test.com', 'Email', Container()),
          Expanded(
            child: buildAbout(),
            flex: 4,
          )
        ],
      ),
     bottomNavigationBar:Padding(
       padding: const EdgeInsets.all(8.0),
       child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            bottomRight:  Radius.circular(15.0),
          ),
          child: BottomNavigationBar(
             unselectedIconTheme: IconThemeData(
    color: Colors.deepOrangeAccent,
  ),
  unselectedItemColor: Colors.deepOrangeAccent,
           backgroundColor: Colors.blueAccent,
    items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
           
            icon: Icon(Icons.person),
            label: 'Personal Info',
          ),
          BottomNavigationBarItem(
            
            icon: Icon(Icons.attach_money_outlined),
            label: 'Salary Info',
          ),
    
    ],
  ),
       ),
     ),
    );
  }

   // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 35,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: TextStyle(fontSize: 16, height: 1.4),
                            ))),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  // Widget builds the About Me Section
  Widget buildAbout() => Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tell Us About Yourself',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              width: 350,
              height: 200,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          // navigateSecondPage(Container());
                        },
                        child: const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'any description',
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ))))),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}