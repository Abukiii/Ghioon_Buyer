import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/CategoryWidgets/CategoryCard.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/CategoryWidgets/CategoryScreen.dart';
import 'package:provider/provider.dart';

import '../../Models/models.dart';
import '../../Providers/AppInfo.dart';
import '../../Services/Database/SellerDatabase/sellerDatabase.dart';
import '../../Shared/constants.dart';
import '../components/emptyScreen.dart';
import 'CategoryWidgets/SellersUnderCategory/Grid.dart';

class CatagoryPage extends StatefulWidget {
  const CatagoryPage({super.key});

  @override
  State<CatagoryPage> createState() => _CatagoryPageState();
}

class _CatagoryPageState extends State<CatagoryPage> {
  @override
  Widget build(BuildContext context) {
    final appInformation = Provider.of<AppInformation>(context);
    final catagory = Provider.of<List<Category>>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(69.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text('Categories',
                    style: TextStyle(
                        fontSize: 28.0,
                        color: appInformation.appColor,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            // excludeHeaderSemantics: true,
            backgroundColor: Colors.white,
            // automaticallyImplyLeading: false,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white)),
      ),
      body: Container(
        height: ScreenSize().ScreenHeight(context),
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: catagory.length == 0
                  ? EmptyScreen(context, 'No Category.')
                  : ListView.builder(
                      shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,
                      itemCount: catagory.length,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      // physics: const NeverScrollableScrollPhysics()
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StreamProvider<
                                        List<SellerInformation>>.value(
                                      initialData: [],
                                      value: SellerDatabaseService(
                                              businessType:
                                                  catagory[index].type)
                                          .sellers,
                                      child: CategoryScreen(category: catagory[index].type,),
                                    ),
                                  ),
                                );
                              },
                              child: CategoryCard(text: catagory[index].type)),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
