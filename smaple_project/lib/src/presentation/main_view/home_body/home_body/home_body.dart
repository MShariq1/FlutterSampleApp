import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaple_project/src/core/constant/image_string.dart';
import 'package:smaple_project/src/core/util/app_utility.dart';
import 'package:smaple_project/src/presentation/providers/home_provider.dart';

import '../../../../../dependency_injector.dart';
import '../../../../core/enum/body_type.dart';
import '../../../../source/models/countriesModel.dart';

class HomeBody extends StatefulWidget {
  final VoidCallback openDrawer;

  const HomeBody({Key? key, required this.openDrawer}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => sl<HomeProvider>().getCountries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(builder: (context, country, child){
        if (country.countriesState == NotifierState.loading) {
          return const Center(child: AppUtility.adaptiveLoader);
        }
        return country.countriesData.fold((failure) =>
          AppUtility.showToast(message: failure.toString())
            // SizedBox.shrink()
            , (data) =>
            _buildUI(data)
        );

      }),

    );
  }

  Widget _buildUI(List<CountriesModel> data ) {
    return Container(
        child: ListView.builder( //).separated(
          padding: const EdgeInsets.all(8),
          itemCount: data.length,
          cacheExtent: 100,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                margin: EdgeInsets.all(12),
                height: MediaQuery.of(context).size.height / 2,
                child: _buildHomeCell(index, data)
            );
          },
          // separatorBuilder: (BuildContext context, int index) => const Divider(),
        )
    );
  }

  Widget _buildHomeCell(int index, List<CountriesModel> data) {
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              image: DecorationImage(
                image: NetworkImage( data[index].flags?.png ?? ''),
                fit: BoxFit.cover,
              ),
            ),

        ),

        Container(
          margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height/2) - 220),
          width: MediaQuery.of(context).size.width - 40,
          height: 220,
          // color: Colors.red,
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12, top: 40),
                    height: 70,
                    width: MediaQuery.of(context).size.width - 130,
                    // color: Colors.yellow,
                    child: Text(data[index].name.official, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Colors.black),),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12, top: 12),
                    height: 70,
                    width: MediaQuery.of(context).size.width - 130,
                    // color: Colors.yellow,
                    child: Row(
                      children: [
                        Container(
                            height: 50, width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              image: DecorationImage(
                                image: AssetImage('assets/image/ic_user_placeholder.png') as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            )

                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          height: 50, //width: 100,
                          child: Column(children: [
                            Container(
                              height: 30,
                              child: Text('Mark Hesley', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),),
                            ),
                            Container(
                              height: 20, width: 90, //color: Colors.black,
                              child: Text('10 min ago', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),),
                            ),
                          ],),
                        )
                      ],
                    ),
                  )
                ],
              ),

            ],
          ),
        )
      ],
    );

  }
}
