import 'package:flutter/material.dart';
import 'package:smaple_project/src/core/extensions/extensions.dart';
import 'package:smaple_project/src/source/models/exams_model.dart';

import '../../../../core/constant/app_string.dart';
import '../../../../core/theme/app_color.dart';

class ExamsBody extends StatefulWidget {
  const ExamsBody({Key? key}) : super(key: key);

  @override
  State<ExamsBody> createState() => _ExamsBodyState();
}

class _ExamsBodyState extends State<ExamsBody>
    with SingleTickerProviderStateMixin {

  late final TabController _tabController;
  var isCurrent = true;
   List<ExamsModel> examsModel = [];

  @override
  void initState() {
    super.initState();
    examsModel = [ExamsModel("Swift", "88", "12/02/23"), ExamsModel("Dart", "67", "12/02/23"), ExamsModel("Php", "76", "12/02/23"), ExamsModel("Node", "96", "12/02/23"), ExamsModel("GO", "90", "12/02/23"), ];
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (_tabController.indexIsChanging) {
          this.isCurrent = _tabController.index == 0;
          switch (_tabController.index) {
            case 0:
              examsModel = [ExamsModel("Swift", "88", "12/02/23"), ExamsModel("Dart", "67", "12/02/23"), ExamsModel("Php", "76", "12/02/23"), ExamsModel("Node", "96", "12/02/23"), ExamsModel("GO", "90", "12/02/23"), ];
            case 1:
              examsModel = [ExamsModel("Dart", "20", "12/02/22"), ExamsModel("Swift", "67", "12/02/22"), ExamsModel("Node", "45", "12/02/22"), ExamsModel("Php", "27", "12/02/22"), ExamsModel("GO", "12", "12/02/2"), ];
            default: break;
          }
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyMedium;
    final labelStyle = textTheme?.copyWith(
        color: AppColor.primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.w600);
    // final eventTypeProvider =
    // Provider.of<EventTypeProvider>(context, listen: false);

    return Column(
      children: [
        SizedBox(
          height: kToolbarHeight + 10,
          child: TabBar(
            controller: _tabController,
            indicatorColor: AppColor.primaryColor,
            tabs: [
              Tab(
                  child: Text(
                    AppString.upComing.t(context),
                    style: labelStyle,
                  )),
              Tab(
                  child: Text(
                    AppString.past.t(context) ,
                    style: labelStyle,
                  )),
            ],
          ),
        ),
        buildUI()
      ],
    );
  }

  Widget buildUI() {
    return Container(
      height: MediaQuery.of(context).size.height - 300,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: examsModel.length,
        itemBuilder: (BuildContext context, int index) {
          return buildCell(index);
        },
      ),
    );
  }

  Widget buildCell(int index) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        height: this.isCurrent ? 80 : 180,
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: !this.isCurrent ? int.parse(this.examsModel[index].marks) < 33 ? Colors.red : Colors.green : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 40, width: 40, margin: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                image: DecorationImage(
                  image: AssetImage('assets/image/my_profile.png') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 0),// color: Colors.yellow,
              width: MediaQuery.of(context).size.width - 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(examsModel[index].subject, style: TextStyle(color: this.isCurrent ? AppColor.primaryColor : Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
                  ),
                  SizedBox(height: 6,),
                  Container(
                    child: Text(examsModel[index].date, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
                  )
                ],
              ),
            ),
            Container(
              height: 30, width: 40,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),

              child: Center(child: Text((examsModel[index].marks).toString(), style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)),
            )
          ],
        ),
      ),
    );
  }
}
