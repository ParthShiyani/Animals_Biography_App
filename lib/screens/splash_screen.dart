import 'package:animal_biography/helpers/db_helper.dart';
import 'package:animal_biography/modals/animal.dart';
import 'package:animal_biography/widgets/next_arrow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../global.dart';
import '../helpers/images_api_helper.dart';
import '../widgets/app_bar.dart';
import '../widgets/circuler_progress_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int index = 0;

  TextStyle titleStyle = TextStyle(
    fontSize: 45,
    color: Colors.white.withOpacity(0.8),
    fontWeight: FontWeight.w600,
  );
  TextStyle titleStyle2 = GoogleFonts.poppins(
    fontSize: 30,
    color: Colors.white.withOpacity(0.8),
    fontWeight: FontWeight.w600,
  );

  TextStyle textStyle = GoogleFonts.poppins(
    fontSize: 20,
    color: Colors.white.withOpacity(0.8),
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: index,
          children: [
            // Splash Screen 1
            Stack(
              children: [
                FutureBuilder(
                  future: ImageAPIHelper.imageAPIHelper
                      .getImage(search: "wild animal"),
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      return Image.memory(
                        snapShot.data!,
                        height: height,
                        width: width,
                        fit: BoxFit.fitHeight,
                        colorBlendMode: BlendMode.modulate,
                        color: const Color(0xffC19E82),
                      );
                    } else if (snapShot.hasError) {
                      return Center(
                        child: Text("${snapShot.error}"),
                      );
                    } else {
                      return circularProgressIndicator();
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appBar(),
                      const Spacer(),
                      Text(
                        "Ready to\nWatch ?",
                        style: titleStyle,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Aplanet is a global leader in real life entertainment, serving a passionate audience of superfans around the world with content that inspires, informs and entertains.",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Start Enjoying",
                        style: textStyle,
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        index = 1;
                      });
                    },
                    child: nextArrow(),
                  ),
                )
              ],
            ),
            // Splash Screen 2
            Stack(
              children: [
                Container(
                  color: const Color(0xffC19E82),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appBar(),
                      const SizedBox(height: 20),
                      Text(
                        "Choose a plan",
                        style: titleStyle2,
                      ),
                      const SizedBox(height: 15),
                      (index == 1)
                          ? Expanded(
                              child: FutureBuilder(
                                future: DBHelper.dbHelper
                                    .fetchAllSubscriptionRecords(
                                        tableName: "plan_screen",
                                        data: Global.subscription),
                                builder: (context, snapShot) {
                                  if (snapShot.hasData) {
                                    List<SubscriptionDB>? res = snapShot.data;

                                    return ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: res!.length,
                                      itemBuilder: (context, i) {
                                        return Container(
                                          height: 140,
                                          margin: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                Color(0xffC19E82),
                                                BlendMode.modulate,
                                              ),
                                              image: MemoryImage(
                                                res[i].image,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 15),
                                              Text(
                                                "${res[i].time}\nSubscription",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 24,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const Spacer(),
                                              SizedBox(
                                                width: width / 3,
                                                child: Text(
                                                  "\$ ${res[i].price}",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 33,
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  } else if (snapShot.hasError) {
                                    return Center(
                                        child:
                                            Text("Errror ${snapShot.error}"));
                                  } else {
                                    return circularProgressIndicator();
                                  }
                                },
                              ),
                            )
                          : Container(),
                      const SizedBox(height: 20),
                      Text(
                        "Last Step to enjoy",
                        style: textStyle,
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("/");
                    },
                    child: nextArrow(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
