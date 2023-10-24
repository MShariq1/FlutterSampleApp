import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaple_project/src/core/constant/route_string.dart';
import 'package:smaple_project/src/core/extensions/extensions.dart';
import 'package:smaple_project/src/presentation/Widgets/sample_app_bar.dart';
import 'package:smaple_project/src/presentation/main_view/home_body/account_body/account_body.dart';
import 'package:smaple_project/src/presentation/main_view/profile_body/profile_body.dart';

import '../../../dependency_injector.dart';
import '../../core/constant/app_string.dart';
import '../../core/constant/image_string.dart';
import '../../core/enum/bottom_navigation.dart';
import '../../core/theme/app_color.dart';
import '../../core/util/app_utility.dart';
import '../Widgets/cached_image.dart';
import '../auth_views/LoginVC.dart';
import '../providers/authentication_provider.dart';
import '../providers/main_view_provider.dart';
import 'home_body/home_body_temp.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  void _openDrawer() => _scaffoldState.currentState?.openDrawer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<Widget> navigateToNotification() => [
    IconButton(onPressed: () {
      // Navigator.pushNamed(context, RouteString.notification);
    }, icon: Icon(Icons.notifications))
  ];

  SampleAppBar? get _appbarForBody {
    final mainViewProvider = Provider.of<MainViewProvider>(context);
    final currentBottomNavigation = mainViewProvider.currentBottomNavigation;
    switch (currentBottomNavigation) {
      case BottomNavigation.account:
        return null;
      default:
        return SampleAppBar(
            title: currentBottomNavigation.name,
            callback: _openDrawer,
            actions: navigateToNotification());
    }

  }

  int maxIndex = 0;

  void _onBottomNavigationTaped(int index) {
    final mainViewProvider = sl<MainViewProvider>();
     maxIndex = index;
     mainViewProvider.currentBottomNavigation = BottomNavigation.values[maxIndex];
  }

  void onDrawerTaped(DrawerItem drawerItem) {
    _onBottomNavigationTaped(0);
    final mainViewProvider =
    Provider.of<MainViewProvider>(context, listen: false);
    if (drawerItem == DrawerItem.login || drawerItem == DrawerItem.logout) {
      if (drawerItem == DrawerItem.logout) { Navigator.pop(context); }
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LoginVC()));
    } else {
      mainViewProvider.currentDrawerItem = drawerItem;
    }
  }

  Widget _drawerTile({required String title,required VoidCallback onTap,required ImageProvider imageProvider}){
    final textTheme = Theme.of(context).textTheme.bodyMedium;
    final titleStyle = textTheme?.copyWith(fontSize: 16, color: AppColor.white);
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          onTap();
          //  onDrawerTaped(DrawerItem.values[index]);
        },
        title: Text(
          title,
          style: titleStyle,
        ),
        leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Colors.red[300]!,
                      Colors.red[900]!
                    ]),
                color: AppColor.primaryColor),
            child: Center(
                child: Image(
                  image: imageProvider,
                  color: Colors.white,
                  height: 20,
                  width: 20,
                ))),
      ),
    );
  }

  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyMedium;
    final nameStyle = textTheme?.copyWith(
        fontSize: 18, color: AppColor.white, fontWeight: FontWeight.w600);
    final emailStyle = textTheme?.copyWith(fontSize: 13, color: AppColor.white);
    final titleStyle = textTheme?.copyWith(fontSize: 16, color: AppColor.white);
    final mainViewProvider = Provider.of<MainViewProvider>(context);
    final showAppbarDrawer = mainViewProvider.showAppBarDrawer;
    final currentBottomNavigation = mainViewProvider.currentBottomNavigation;
    final currentDrawerItem = mainViewProvider.currentDrawerItem;
    return Scaffold(
      key: _scaffoldState,
      resizeToAvoidBottomInset: false,
      appBar: [
        ///appBar for drawer
        SampleAppBar(title: currentDrawerItem.name, callback: _openDrawer),
        ///appbar for body
        _appbarForBody
      ].elementAt(showAppbarDrawer ? 1 : 0),

      drawer: Consumer<AuthenticationProvider>(
          builder: (_,authentication,child) {
            return SafeArea(
              child: SizedBox(
                width: 370,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 22),
                        child: ClipPath(
                          //to add curve in drawer
                            // clipper: BuyTicketClipper(),
                            child: Container(
                              color: AppColor.primaryColor,
                              child: const ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(40),
                                      bottomRight: Radius.circular(40)),
                                  // child: Image(
                                  //     image: ImageString.sideDrawer,
                                  //     fit: BoxFit.cover)
                              ),
                            )
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 70),
                              SizedBox(
                            // height: 100,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 10),
                                CachedAvatarImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-EyOc3j3ztZRSbJDc-I_tz8ZqGYZOoeLNsQz_zLk&s",dimension: 60,padding: 2),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("John Doe", style: nameStyle),
                                    Text('john.doe@gmail.com', style: emailStyle),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // ),
                        const SizedBox(height: 40),
                        ///drawer Tile
                        _drawerTile(
                          title: DrawerItem.home.name,
                          onTap:()=> onDrawerTaped(DrawerItem.home),
                          imageProvider: DrawerItem.home.image,
                        ),
                        _drawerTile(
                          title: DrawerItem.profile.name,
                          onTap:()=> onDrawerTaped(DrawerItem.profile),
                          imageProvider: DrawerItem.profile.image,
                        ),
                        _drawerTile(
                          title: DrawerItem.login.name,
                          onTap:()=> onDrawerTaped(DrawerItem.login),
                          imageProvider: DrawerItem.login.image,
                        ),
                          _drawerTile(
                            title: DrawerItem.logout.name,
                            onTap:()async{
                              FocusScope.of(context).unfocus();
                              AppUtility.blockLoader(context);
                              final value = await authentication.logout();
                              value.fold((failure) => Navigator.pop(context), (success) =>
                                onDrawerTaped(DrawerItem.logout)
                              );
                            },
                            imageProvider: DrawerItem.logout.image,
                          ),
                      ],
                    ),
                    //to add cross button
                    // Positioned(
                    //   right: 0,
                    //   top: MediaQuery.of(context).size.height/2 - 80,
                    //   //top: MediaQuery.of(context).size.height
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.pop(context);
                    //     },
                    //     child: Container(
                    //       height: 44,
                    //       width: 44,
                    //       padding: EdgeInsets.zero,
                    //       decoration: const BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: AppColor.primaryColor,
                    //       ),
                    //       child: const Center(
                    //           child: Image(
                    //             image: ImageString.close,
                    //             color: Colors.white,
                    //           )),
                    //     ),
                    //   ),
                    // ),
                    const Align(
                      alignment: Alignment(.5, 0),
                    )
                  ],
                ),
              ),
            );
          }
      ),
      body: [
        HomeBodyTemp(drawerCallBack: _openDrawer),
        const ProfileBody(),
        const LoginVC(),
        const SizedBox.shrink()
      ].elementAt(currentDrawerItem.index),
      bottomNavigationBar: showAppbarDrawer
          ? BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: AppColor.black,
        onTap: _onBottomNavigationTaped,
        currentIndex: currentBottomNavigation.index,
        items: List.generate(
          BottomNavigation.values.length,
              (index) => BottomNavigationBarItem(
            icon: SizedBox.square(
              dimension: 24,
              child: Image(
                image: BottomNavigation.values[index].image,
                color: index == currentBottomNavigation.index
                    ? AppColor.primaryColor
                    : AppColor.inActiveGrey,
              ),
            ),
            label: BottomNavigation.values[index].name,
          ),
        ),
      )
          : null,
    );
  }
}





class BuyTicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    //path.addOval(Rect.fromCircle(center: Offset(0.0, size.height/1.6), radius: 20.0));
    path.addOval(
        Rect.fromCircle(center: Offset(size.width + 4, size.height/2-20), radius: 50.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class DrawerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    //path.addOval(Rect.fromCircle(center: Offset(0.0, size.height/1.6), radius: 20.0));
    path.addOval(
        Rect.fromCircle(center: Offset(size.width + 4, size.height - 40), radius: 50.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}


