import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constant/image_string.dart';
import '../../core/theme/app_color.dart';

class SampleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? callback;
  final List<Widget>? actions;

  const SampleAppBar({Key? key,this.callback,required this.title,this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColor.white,fontWeight: FontWeight.w600,fontSize: 16);
    return AppBar(
      title: Text(title, style: titleStyle),
      centerTitle: true,
      backgroundColor: AppColor.primaryColor,
      leading: callback!=null?IconButton(
        onPressed: callback,
        icon: const SizedBox.square(
          dimension: 34,
          child: Image(image: ImageString.menu),
        ),
      ):null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
