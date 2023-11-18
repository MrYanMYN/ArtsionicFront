import 'dart:typed_data';

import 'package:artsionic_app/utils/items_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/itemsState.dart';
import 'styles.dart';

class ImageGenerationPage extends StatefulWidget {
  const ImageGenerationPage({super.key, required this.title});
  final String title;

  @override
  State<ImageGenerationPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ImageGenerationPage> {
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<ImageGen> items =
        Provider.of<ItemsState>(context, listen: true).itemsImages;
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
                    "Image Generation",
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
                      return ImageGenItem(
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
            Provider.of<ItemsState>(context, listen: false).refreashImages(),
        tooltip: 'refresh',
        child: const Icon(
          Icons.refresh,
          color: menuTextHeadingColor,
        ),
      ),
    );
  }
}

class ImageGenItem extends StatelessWidget {
  final int index;
  final List<ImageGen> items;
  const ImageGenItem({super.key, required this.index, required this.items});
  @override
  Widget build(BuildContext context) {
    int keyId = items.elementAt(index).id;
    ImageGen foundItem = items.firstWhere((item) => item.id == keyId);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/image'),
              child: PhotoHero(
                id: keyId,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return Scaffold(
                          body: Center(
                            child: Container(
                              color: Colors.grey[800],
                              alignment: Alignment.center,
                              child: PhotoHero(
                                id: keyId,
                                photo: foundItem.imageBytes,
                                width: MediaQuery.of(context).size.width,
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                photo: foundItem.imageBytes,
                width: MediaQuery.of(context).size.width,
                // tag: items[key]?["id"],
                // child: AspectRatio(
                //   aspectRatio: 1.0,
                //   child: Container(
                //     height: MediaQuery.of(context).size.height / 4,
                //     width: MediaQuery.of(context).size.width - 50,
                //     decoration: BoxDecoration(
                //         gradient: LinearGradient(
                //           colors: [
                //             Color.fromARGB(255, 255, 255, 255),
                //             Color.fromARGB(69, 252, 255, 255),
                //           ],
                //           end: Alignment.bottomRight,
                //           stops: [0.1, 0.9],
                //         ),
                //         borderRadius: BorderRadius.circular(20)),
                //   ),
                // ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 40,
            child: ElevatedButton(
              onPressed: () {
                Provider.of<ItemsState>(context, listen: false)
                    .acceptImagePhase(foundItem.id);
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
          Positioned(
            bottom: 0,
            right: 110,
            child: ElevatedButton(
              onPressed: () {
                Provider.of<ItemsState>(context, listen: false)
                    .declineImagePhase(foundItem.id);
              },
              child: Icon(Icons.remove,
                  color: Colors.white), // Using an add icon for demonstration
              style: ButtonStyle(
                shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
                padding: MaterialStateProperty.all(EdgeInsets.all(
                    16)), // Adjust padding based on your requirements
                backgroundColor: MaterialStateProperty.all(
                    Colors.red), // Background color of the button
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 40,
            child: ElevatedButton(
              onPressed: () => Provider.of<ItemsState>(context, listen: false)
                  .refreashImagePhase(foundItem.id),
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
          ),
          Positioned(
            bottom: 0,
            left: 110,
            child: ElevatedButton(
              onPressed: () {
                // Handle button tap
              },
              child: Icon(Icons.auto_awesome,
                  color: buttonText), // Using an add icon for demonstration
              style: ButtonStyle(
                shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
                padding: MaterialStateProperty.all(EdgeInsets.all(
                    16)), // Adjust padding based on your requirements
                backgroundColor: MaterialStateProperty.all(
                    buttonBackground), // Background color of the button
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              decoration: BoxDecoration(
                color: topicBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  foundItem.trend,
                  style: TextStyle(
                      fontSize: 16,
                      color: topicText,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Positioned(
            top: 65,
            left: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.purple[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Resolution: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: foundItem.image_data[0],
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.orange[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Engine: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: foundItem.image_data[1],
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero(
      {super.key,
      required this.id,
      required this.photo,
      required this.onTap,
      required this.width});

  final Uint8List photo;
  final VoidCallback onTap;
  final double width;
  final int id;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: id,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.memory(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
