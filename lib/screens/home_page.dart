import 'dart:typed_data';
import 'package:animal_biography/helpers/db_helper.dart';
import 'package:animal_biography/modals/animal.dart';
import 'package:animal_biography/widgets/app_bar.dart';
import 'package:animal_biography/widgets/circuler_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import '../global.dart';
import '../helpers/images_api_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height * 0.3,
              color: Global.color.withOpacity(0.8),
              child: Stack(
                children: [
                  FutureBuilder(
                    future: ImageAPIHelper.imageAPIHelper
                        .getImage(search: "elephant"),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        Uint8List? image = snapShot.data;
                        return Image.memory(
                          height: height * 0.38,
                          width: double.infinity,
                          image!,
                          fit: BoxFit.cover,
                          color: Global.color.withOpacity(0.8),
                          colorBlendMode: BlendMode.modulate,
                        );
                      } else if (snapShot.hasError) {
                        return Center(child: Text("${snapShot.error}"));
                      } else {
                        return circularProgressIndicator();
                      }
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        appBar(),
                        SizedBox(height: 20),
                        Text(
                          "Welcome to\nNew Aplanet",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            color: Colors.white.withOpacity(0.86),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        // SizedBox(height: height * 0.1),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * 0.70,
                width: width,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Global.color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Related for you",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    FutureBuilder(
                      future: DBHelper.dbHelper.fetchAllAnimalData(
                          tableName: "animalsData", data: Global.animal),
                      builder: (context, snapShot) {
                        if (snapShot.hasData) {
                          List<AnimalDB> res = snapShot.data!;
                          return SizedBox(
                            height: height * 0.45,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: res.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    right: 15,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: height * 0.31,
                                        width: width * 0.5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              blurRadius: 3,
                                            )
                                          ],
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: MemoryImage(res[i].image),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        res[i].name,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.5,
                                        child: Text(
                                          res[i].description,
                                          style: GoogleFonts.poppins(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (snapShot.hasError) {
                          return Center(child: Text("${snapShot.error}"));
                        } else {
                          return circularProgressIndicator();
                        }
                      },
                    ),
                    Text(
                      "Quick Categories",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...Global.button
                            .map((e) => Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        (e['name'] == "BEAR")
                                            ? Global.category = "Bear"
                                            : (e['name'] == "LION")
                                                ? Global.category = "Lion"
                                                : (e['name'] == "SNAKE")
                                                    ? Global.category = "Snake"
                                                    : Global.category = "Dog";
                                        setState(() {});
                                      },
                                      child: Text(
                                        e["icon"],
                                        style: TextStyle(fontSize: 35),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffeed0b3),
                                        padding: const EdgeInsets.all(15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        e['name'],
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ))
                            .toList(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
