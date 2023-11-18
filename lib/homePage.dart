import 'package:artsionic_app/widgets/select_from_3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'styles.dart';
import 'utils/itemsState.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ItemsState>(context, listen: false).refreashPosts();
    Provider.of<ItemsState>(context, listen: false).refreashImages();
    Provider.of<ItemsState>(context, listen: false).refreashTrends();
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Text(
                    "Main Menu",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: menuTextHeadingColor,
                    ),
                  ),
                ),
                MenuItemReversed(
                  titleCard: "Trends",
                  titleDesc: "Trend Filtration",
                  descriptionDesc:
                      "Filter thrugh current trends before generation begins",
                  updateNoun: "trends",
                  iconCard: Icons.stacked_bar_chart,
                  buttonFunc: () => Navigator.pushNamed(context, "/trends"),
                ),
                MenuItem(
                  titleCard: "Images",
                  titleDesc: "Image Generation",
                  descriptionDesc:
                      "Batch image generation of any trends detected in the past week",
                  updateNoun: "images",
                  iconCard: Icons.image_outlined,
                  buttonFunc: () => Navigator.pushNamed(context, "/images"),
                ),
                MenuItemReversed(
                  titleCard: "Posts",
                  titleDesc: "Post Generation",
                  descriptionDesc:
                      "Check out new post before they go become live and get published.",
                  iconCard: Icons.share,
                  updateNoun: "posts",
                  buttonFunc: () => Navigator.pushNamed(context, "/posts"),
                ),
                MenuItem(
                    titleCard: "Analysis",
                    titleDesc: "Product Analysis",
                    descriptionDesc:
                        "Analyze product performance and create ad campains",
                    updateNoun: "alerts",
                    iconCard: Icons.analytics_outlined,
                    buttonFunc: () {}),
                ShopBlock(
                  title: "Shopify Store",
                  link: "https://d85a67.myshopify.com/",
                  shopIcon: Icons.shopify,
                ),
                ShopBlock(
                  title: "Etsy",
                  link: "",
                  shopIcon: Icons.e_mobiledata,
                ),
                ShopBlock(
                  title: "Instagram",
                  link: "",
                  shopIcon: Icons.camera,
                )
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'refresh',
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }
}

class ShopBlock extends StatelessWidget {
  final String title;
  final String link;
  final IconData shopIcon;
  ShopBlock({
    super.key,
    required this.title,
    required this.link,
    required this.shopIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(link)),
        child: Container(
          decoration: BoxDecoration(
            // color: Color.fromARGB(170, 96, 229, 247),
            gradient: LinearGradient(
              colors: colorGradient,
              end: Alignment.bottomRight,
              stops: [0.3, 0.9],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    shopIcon,
                    color: Color.fromARGB(250, 115, 223, 238),
                    size: 56,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: menuTextHeadingColor,
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

class MenuItem extends StatelessWidget {
  final String titleCard;
  final String titleDesc;
  final String descriptionDesc;
  final String updateNoun;
  final IconData iconCard;
  final Function()? buttonFunc;

  MenuItem({
    required this.updateNoun,
    required this.descriptionDesc,
    required this.titleDesc,
    required this.titleCard,
    required this.iconCard,
    required this.buttonFunc,
  });

  @override
  Widget build(BuildContext context) {
    int count = 0;
    if (updateNoun == "images") {
      count = Provider.of<ItemsState>(context, listen: true).itemsImages.length;
    } else if (updateNoun == "alerts") {
      count =
          Provider.of<ItemsState>(context, listen: true).itemsAnalysis.length;
    } else {
      count = 0;
    }
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 5,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Color.fromARGB(170, 96, 229, 247),
                      gradient: LinearGradient(
                        colors: colorGradient,
                        end: Alignment.topCenter,
                        stops: [0.3, 0.9],
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(
                            iconCard,
                            color: Color.fromARGB(250, 115, 223, 238),
                            size: 120,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            titleCard,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: menuTextHeadingColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "${count} new ${updateNoun}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: menuTextBodyColor,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
          Expanded(
              flex: 7,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titleDesc,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: menuTextHeadingColor),
                      ),
                      Text(
                        descriptionDesc,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: menuTextBodyColor,
                          fontSize: 16,
                        ),
                      ),
                      FilledButton(
                        onPressed: buttonFunc,
                        child: Text("Explore"),
                        style: exploreButtonStyle,
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class MenuItemReversed extends StatelessWidget {
  final String titleCard;
  final String titleDesc;
  final String descriptionDesc;
  final String updateNoun;
  final Function()? buttonFunc;
  final IconData iconCard;

  MenuItemReversed({
    required this.updateNoun,
    required this.descriptionDesc,
    required this.titleDesc,
    required this.titleCard,
    required this.buttonFunc,
    required this.iconCard,
  });

  @override
  Widget build(BuildContext context) {
    int count = 0;
    if (updateNoun == "posts") {
      count = Provider.of<ItemsState>(context, listen: true).itemsPosts.length;
    } else if (updateNoun == "trends") {
      count =
          Provider.of<ItemsState>(context, listen: true).getAmountOfTrends();
    } else {
      count = 10;
    }
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 7,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      titleDesc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: menuTextHeadingColor,
                      ),
                    ),
                    Text(
                      descriptionDesc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: menuTextBodyColor,
                        fontSize: 16,
                      ),
                    ),
                    FilledButton(
                        onPressed: buttonFunc,
                        child: Text("Explore"),
                        style: exploreButtonStyle)
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 5,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Color.fromARGB(170, 96, 229, 247),
                      gradient: LinearGradient(
                        colors: colorGradient,
                        end: Alignment.topCenter,
                        stops: [0.2, 0.9],
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(
                            iconCard,
                            color: Color.fromARGB(250, 115, 223, 238),
                            size: 120,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            titleCard,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: menuTextHeadingColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "${count} new ${updateNoun}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: menuTextBodyColor,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
