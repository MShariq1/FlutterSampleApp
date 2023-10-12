import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaple_project/src/core/extensions/extensions.dart';
import 'package:smaple_project/src/presentation/providers/locale_provider.dart';

import '../../../../../dependency_injector.dart';
import '../../../../core/constant/app_string.dart';
import '../../../../core/constant/image_string.dart';
import '../../../../core/constant/route_string.dart';
import '../../../../core/enum/bottom_navigation.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/util/app_utility.dart';
import '../../../Widgets/cached_image.dart';
import '../../../providers/main_view_provider.dart';
import 'my_profile_view.dart';

class AccountBody extends StatefulWidget {
  final VoidCallback openDrawer;

  const AccountBody({Key? key, required this.openDrawer}) : super(key: key);

  static const _divider = Divider(
      endIndent: AppUtility.horizontalSpacing,
      indent: AppUtility.horizontalSpacing);

  @override
  State<AccountBody> createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody> {
  ///
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyMedium;
    final titleStyle = textTheme?.copyWith(
        color: AppColor.white, fontWeight: FontWeight.w600, fontSize: 18);
    final nameStyle =
    textTheme?.copyWith(fontSize: 18, fontWeight: FontWeight.w600);
    final emailStyle =
    textTheme?.copyWith(fontSize: 14, fontWeight: FontWeight.w400);
    final mainViewProvider = sl<MainViewProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ///appbar
      SizedBox(
      height: 320,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: AppBar(
                  title: Text(AppString.myAccount, style: titleStyle),
                  centerTitle: true,
                  backgroundColor: AppColor.primaryColor,
                  leading: IconButton(
                    onPressed: widget.openDrawer,
                    icon: const SizedBox.square(
                      dimension: 34,
                      child: Image(image: ImageString.menu),
                    ),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, RouteString.notification);
                        },
                        icon: const Icon(Icons.notifications))
                  ],
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      // image: DecorationImage(
                      //     image: ImageString.appBarBackground,
                      //     fit: BoxFit.fitWidth),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("John Doe",
                        style: nameStyle),
                    const SizedBox(height: 6),
                    Text("john.doe@gmail.com", style: emailStyle),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: const Alignment(0.0, 0.4),
            child: CachedAvatarImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-EyOc3j3ztZRSbJDc-I_tz8ZqGYZOoeLNsQz_zLk&s",dimension: 140,),
            ),

        ],
      ),
    ),

        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: ListBody(
              children: [
                _titleBuilder(
                    context, AppString.myProfile, ImageString.myProfile, () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (_) => const MyProfileView()));
                  print('Profile');
                }),
                AccountBody._divider,
                _titleBuilder(context, AppString.myEvents, ImageString.myEvents,
                        () {
                      print('Events');
                    }),
                AccountBody._divider,
                _titleBuilder(
                    context, AppString.favorite, ImageString.favorites, () {
                  print('Favourites');
                }),
                AccountBody._divider,
                _titleBuilder(
                    context, 'language'.t(context), ImageString.following, () {
                      print('Following---------------------');
                      sl<LocaleProvider>().togggle();
                      print(context.read<LocaleProvider>().locale.languageCode);
                }),
                AccountBody._divider,
                _titleBuilder(
                  context,
                  AppString.deleteAccount,
                  ImageString.delete,
                      () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          final textTheme =
                              Theme.of(context).textTheme.bodyMedium;
                          final titleStyle = textTheme?.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 24);
                          final descriptionStyle =
                          textTheme?.copyWith(fontSize: 13);
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            surfaceTintColor: AppColor.white,
                            actionsPadding: EdgeInsets.zero,
                            actionsOverflowButtonSpacing: 0.0,
                            titlePadding: EdgeInsets.zero,
                            iconPadding: EdgeInsets.zero,
                            icon: Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close))),
                            title: Text("Delete Account",
                                style: titleStyle, textAlign: TextAlign.center),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    AppString.deleteAccountDescription
                                        .t(context),
                                    style: descriptionStyle,
                                    textAlign: TextAlign.center),
                                const SizedBox(height: 20),
                                SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          print('Account Deleted');
                                          Navigator.pop(context);
                                        },
                                        child: Text("Confirm")))
                              ],
                            ),
                          );
                        });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _titleBuilder(context, String title, ImageProvider imageProvider,
      [VoidCallback? callback]) {
    final textTheme = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600);

    return ListTile(
      onTap: callback,
      leading: SizedBox.square(
        dimension: 48,
        child: Image(image: imageProvider),
      ),
      title: Text(title, style: textTheme),
      trailing: const IconButton(
          onPressed: null, icon:  Icon(Icons.arrow_forward_ios)),
    );
  }
}
