import 'package:artsionic_app/utils/items_api.dart';
import 'package:artsionic_app/widgets/select_from_3.dart';
import 'package:artsionic_app/widgets/customTrend.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/itemsState.dart';
import 'styles.dart';
import 'dart:math';

class TrendFiltrationPage extends StatefulWidget {
  const TrendFiltrationPage({super.key, required this.title});
  final String title;

  @override
  State<TrendFiltrationPage> createState() => _TrendFiltrationPageState();
}

class _TrendFiltrationPageState extends State<TrendFiltrationPage> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Trend> items =
        Provider.of<ItemsState>(context, listen: true).getCurrentRegion();
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 120, bottom: 30),
                      child: Text(
                        "Trends",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: menuTextHeadingColor,
                        ),
                      ),
                    ),
                    FreeFormTrend(myController: myController),
                    SelectFrom3(),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 330,
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return TrendFilItem(
                        index: index,
                        items: items,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 100,
          left: 20,
          child: Container(
            width: 70,
            height: 70,
            child: FilledButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(4),
                backgroundColor: MaterialStateProperty.all(backButtonBG),
                minimumSize: MaterialStateProperty.all(Size(50,
                    50)), // Change the value (50, 50) as per the desired size of your square button.
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.arrow_back_sharp,
                color: menuTextHeadingColor,
              ),
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: backButtonBG,
        onPressed: () =>
            Provider.of<ItemsState>(context, listen: false).refreashTrends(),
        tooltip: 'refresh',
        child: const Icon(
          Icons.refresh,
          color: menuTextHeadingColor,
        ),
      ),
    );
  }
}

class TrendFilItem extends StatelessWidget {
  final int index;
  final List<Trend> items;
  const TrendFilItem({
    super.key,
    required this.index,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    Color getRandomPastelColor() {
      final Random random = Random();

      // Generates a random primary color value between 0 and 55 for dark colors.
      int randomPrimaryValue() => random.nextInt(200);

      return Color.fromRGBO(
        randomPrimaryValue(),
        randomPrimaryValue(),
        randomPrimaryValue(),
        1,
      );
    }

    String keyId = items.elementAt(index).trend;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              width: MediaQuery.of(context).size.width - 30,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: colorGradient,
                    end: Alignment.bottomRight,
                    stops: [0.1, 0.9],
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, top: 3),
                    child: IntrinsicWidth(
                      child: Container(
                        // width: MediaQuery.of(context).size.width / 2,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: topicBackground,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: RichText(
                          softWrap: true,
                          text: TextSpan(
                            text: keyId,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 140,
                                height: 150,
                                child: ListView.builder(
                                  itemCount: items
                                      .elementAt(index)
                                      .relatedTopics
                                      .length,
                                  itemBuilder: (context, relatedTopicIndex) {
                                    var relatedTopics =
                                        items.elementAt(index).relatedTopics;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: IntrinsicWidth(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: getRandomPastelColor(),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                              child: RichText(
                                            softWrap: true,
                                            text: TextSpan(
                                              text: relatedTopics[
                                                  relatedTopicIndex],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: menuTextHeadingColor),
                                            ),
                                          )),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 220,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 40,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'News Related: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: menuTextHeadingColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: items.elementAt(index).news,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: menuTextHeadingColor),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 40,
            child: ElevatedButton(
              onPressed: () {
                Provider.of<ItemsState>(context, listen: false)
                    .acceptTopic(keyId);
              },
              child: Icon(Icons.verified,
                  color: Colors.white), // Using an add icon for demonstration
              style: ButtonStyle(
                shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
                padding: MaterialStateProperty.all(EdgeInsets.all(
                    16)), // Adjust padding based on your requirements
                backgroundColor: MaterialStateProperty.all(
                    Colors.green), // Background color of the button
              ),
            ),
          ),
        ],
      ),
    );
  }
}
