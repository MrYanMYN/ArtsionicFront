import 'package:artsionic_app/utils/items_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'styles.dart';
import 'utils/itemsState.dart';

class PostGenerationPage extends StatefulWidget {
  const PostGenerationPage({super.key, required this.title});
  final String title;

  @override
  State<PostGenerationPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PostGenerationPage> {
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<PostGen> items =
        Provider.of<ItemsState>(context, listen: true).itemsPosts;
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(children: [
        Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 120, bottom: 30),
                    child: Text(
                      "Post Generation",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: menuTextHeadingColor,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return PostGenItem(index: index, items: items);
                      },
                    ),
                  ),
                ],
              )),
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
            Provider.of<ItemsState>(context, listen: false).refreashPosts(),
        tooltip: 'refresh',
        child: const Icon(
          Icons.refresh,
          color: menuTextHeadingColor,
        ),
      ),
    );
  }
}

class PostGenItem extends StatelessWidget {
  final int index;
  final List<PostGen> items;
  const PostGenItem({
    super.key,
    required this.index,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    int keyId = items.elementAt(index).id;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: PostHero(
              items: items,
              searchID: keyId,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return PostPage(keyId: keyId, items: items);
                    },
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Provider.of<ItemsState>(context, listen: false)
                    .acceptPostPhase(keyId);
              },
              child: Icon(Icons.verified,
                  color: Colors.white), // Using an add icon for demonstration
              style: ButtonStyle(
                shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
                padding: MaterialStateProperty.all(EdgeInsets.all(
                    16)), // Adjust padding based on your requirements
                backgroundColor: MaterialStateProperty.all(
                    Colors.green.shade700), // Background color of the button
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 90,
            child: ElevatedButton(
              onPressed: () {
                Provider.of<ItemsState>(context, listen: false)
                    .declinePostPhase(keyId);
              },
              child: Icon(Icons.remove,
                  color: Colors.white), // Using an add icon for demonstration
              style: ButtonStyle(
                shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
                padding: MaterialStateProperty.all(EdgeInsets.all(
                    16)), // Adjust padding based on your requirements
                backgroundColor: MaterialStateProperty.all(
                    Colors.red.shade700), // Background color of the button
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 160,
            child: ElevatedButton(
              onPressed: () {
                // Handle button tap
              },
              child: Icon(Icons.refresh,
                  color: buttonText), // Using an add icon for demonstration
              style: ButtonStyle(
                shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
                padding: MaterialStateProperty.all(EdgeInsets.all(
                    16)), // Adjust padding based on your requirements
                backgroundColor: MaterialStateProperty.all(
                    buttonBackground), // Background color of the button
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PostPage extends StatelessWidget {
  const PostPage({
    super.key,
    required this.keyId,
    required this.items,
  });

  final int keyId;
  final List<PostGen> items;

  @override
  Widget build(BuildContext context) {
    PostGen foundItem = items.firstWhere((item) => item.id == keyId);
    return Scaffold(
      body: Hero(
        tag: keyId,
        child: Material(
          color: bgColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 120, bottom: 30),
                        child: Text(
                          "Item ${keyId}",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: menuTextHeadingColor),
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
                            backgroundColor:
                                MaterialStateProperty.all(backButtonBG),
                            minimumSize: MaterialStateProperty.all(Size(50,
                                50)), // Change the value (50, 50) as per the desired size of your square button.
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
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
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 180,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: IntrinsicWidth(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: topicBackground,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Text(
                                              foundItem.trend,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: topicText,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          30,
                                      child: AspectRatio(
                                          aspectRatio: 1.0,
                                          child: Image.memory(
                                              foundItem.imageBytes)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 18),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                30,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: colorGradient,
                                              end: Alignment.bottomRight,
                                              stops: [0.1, 0.9],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      30,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      IntrinsicWidth(
                                                        child: Container(
                                                          height: 35,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .purple[200],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10),
                                                              child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text:
                                                                          'Resolution: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: foundItem
                                                                          .image_data[0],
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      IntrinsicWidth(
                                                        child: Container(
                                                          height: 35,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .orange[200],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10),
                                                              child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text:
                                                                          'Engine: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: foundItem
                                                                          .image_data[1],
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      30,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Prompt: ',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                menuTextHeadingColor,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              foundItem.prompt,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  menuTextHeadingColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              height: 60,
                                              child: ListView.builder(
                                                padding: EdgeInsets.all(8),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    foundItem.hashtags.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                              vertical: 0),
                                                      decoration: BoxDecoration(
                                                        color: topicBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          foundItem
                                                              .hashtags[index],
                                                          style: TextStyle(
                                                              color: topicText,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  60,
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Description: ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            menuTextHeadingColor,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          foundItem.description,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color:
                                                              menuTextHeadingColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Provider.of<ItemsState>(context,
                                          listen: false)
                                      .acceptPostPhase(keyId);
                                  Navigator.of(context).pop();
                                },
                                child: Icon(Icons.verified,
                                    color: Colors
                                        .white), // Using an add icon for demonstration
                                style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all<CircleBorder>(
                                          CircleBorder()),
                                  padding: MaterialStateProperty.all(EdgeInsets.all(
                                      16)), // Adjust padding based on your requirements
                                  backgroundColor: MaterialStateProperty.all(Colors
                                      .green
                                      .shade700), // Background color of the button
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Provider.of<ItemsState>(context,
                                          listen: false)
                                      .declinePostPhase(keyId);
                                  Navigator.of(context).pop();
                                },
                                child: Icon(Icons.remove,
                                    color: Colors
                                        .white), // Using an add icon for demonstration
                                style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all<CircleBorder>(
                                          CircleBorder()),
                                  padding: MaterialStateProperty.all(EdgeInsets.all(
                                      16)), // Adjust padding based on your requirements
                                  backgroundColor: MaterialStateProperty.all(Colors
                                      .red
                                      .shade700), // Background color of the button
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PostHero extends StatelessWidget {
  const PostHero({
    super.key,
    required this.items,
    required this.searchID,
    required this.onTap,
  });

  final List<PostGen> items;
  final VoidCallback onTap;
  final int searchID;

  Widget build(BuildContext context) {
    PostGen foundItem = items.firstWhere((item) => item.id == searchID);
    // Print the title of the found item
    return Hero(
        tag: searchID,
        child: GestureDetector(
          onTap: onTap,
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
            child: Row(
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
                          height: 140,
                          child: Image.memory(foundItem.imageBytes),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 90,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: topicBackground,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: RichText(
                            softWrap: true,
                            text: TextSpan(
                              text: foundItem.trend,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: topicText,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
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
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Description: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: menuTextHeadingColor,
                                ),
                              ),
                              TextSpan(
                                text: foundItem.description,
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
          ),
        ));
  }
}
