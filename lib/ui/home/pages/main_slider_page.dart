// import 'package:collapsible_sidebar/collapsible_sidebar.dart';
// import 'package:erb_mobo/ui/home/widgets/aprovment_requests_list.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class MainSidebarPage extends StatefulWidget {
//   const MainSidebarPage({Key? key}) : super(key: key);

//   @override
//   _MainSidebarPageState createState() => _MainSidebarPageState();
// }

// class _MainSidebarPageState extends State<MainSidebarPage> {
//   late List<CollapsibleItem> _items;
//   late String _headline;

//   @override
//   void initState() {
//     super.initState();
//     _items = _generateItems;
//     _headline = _items.firstWhere((item) => item.isSelected).text;
//   }

//   List<CollapsibleItem> get _generateItems {
//     return [
//       CollapsibleItem(
//         text: 'Approvement requests',
//         icon: Icons.assessment,
//         onPressed: () => setState(() => _headline = 'Approvement requests'),
//         isSelected: true,
//       ),
//       CollapsibleItem(
//         text: 'Notifications',
//         icon: Icons.notifications,
//         onPressed: () => setState(() => _headline = 'Notifications'),
//       ),
//       CollapsibleItem(
//         text: 'Settings',
//         icon: Icons.settings,
//         onPressed: () => setState(() => _headline = 'Settings'),
//       ),
//       CollapsibleItem(
//         text: 'Home',
//         icon: Icons.home,
//         onPressed: () => setState(() => _headline = 'Home'),
//       ),
//       CollapsibleItem(
//         text: 'Event',
//         icon: Icons.event,
//         onPressed: () => setState(() => _headline = 'Event'),
//       ),
//       CollapsibleItem(
//         text: 'Email',
//         icon: Icons.email,
//         onPressed: () => setState(() => _headline = 'Email'),
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: CollapsibleSidebar(
//         isCollapsed: true,
//         items: _items,
//          // avatarImg: _avatarImg,
//         title: 'John Smith',
//         toggleTitle:'Erp Menu',
//         // onTitleTap: () {
//         //   ScaffoldMessenger.of(context).showSnackBar(
//         //       SnackBar(content: Text('Yay! Flutter Collapsible Sidebar!')));
//         // },
//         body: _body(context),
//         backgroundColor: Colors.black,
//         selectedTextColor: Theme.of(context).primaryColor,
//         textStyle: TextStyle(fontSize: ScreenUtil().setSp(15), fontStyle: FontStyle.italic),
//         titleStyle: TextStyle(
//             fontSize: ScreenUtil().setSp(20),
//             fontStyle: FontStyle.italic,
//             fontWeight: FontWeight.bold),
//         toggleTitleStyle: TextStyle(fontSize: ScreenUtil().setSp(20), fontWeight: FontWeight.bold),
//         sidebarBoxShadow: const [
//           BoxShadow(
//             color: Colors.indigo,
//             blurRadius: 20,
//             spreadRadius: 0.01,
//             offset: Offset(3, 3),
//           ),
//           BoxShadow(
//             color: Colors.green,
//             blurRadius: 50,
//             spreadRadius: 0.01,
//             offset: Offset(3, 3),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _body(BuildContext context) {
//   //   return Container(
//   //     height: double.infinity,
//   //     width: double.infinity,
//   //     color: Colors.blueGrey[50],
//   //     child: _headline == 'Approvement requests' ? const ApprovmentRequestsList():Text(_headline)
//   //   );
//   // }
// }