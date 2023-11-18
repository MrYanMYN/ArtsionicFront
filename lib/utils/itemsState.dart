import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'items_api.dart';

class ItemsState extends ChangeNotifier {
  int _selectedRegion = 0;
  int get selectedRegion => _selectedRegion;
  List<Trend> _trendsCanada = [];
  List<Trend> _trendsUS = [];
  List<Trend> _trendsUK = [];

  // Map<String, Map<String, dynamic>> _trendsCanada = {
  //   "Blink 182": {
  //     "news":
  //         "Relevant new to the topic the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your ",
  //     "topics": ["Music", "Concerts", "Theme Parks", "TV Shows"]
  //   },
  //   "Blink 1823": {
  //     "news":
  //         "Relevant new to the topic the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your ",
  //     "topics": ["Music", "Concerts", "Theme Parks", "TV Shows"]
  //   },
  //   "Blink 1824": {
  //     "news":
  //         "Relevant new to the topic the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your ",
  //     "topics": ["Music", "Concerts", "Theme Parks", "TV Shows"]
  //   },
  //   "Blink 1825": {
  //     "news":
  //         "Relevant new to the topic the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your ",
  //     "topics": ["Music", "Concerts", "Theme Parks", "TV Shows"]
  //   },
  //   "Blink 1826": {
  //     "news":
  //         "Relevant new to the topic the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your ",
  //     "topics": ["Music", "Concerts", "Theme Parks", "TV Shows"]
  //   },
  // };
  // Map<String, Map<String, dynamic>> _trendsUS = {
  //   "Star Wars": {
  //     "news":
  //         "Relevant new to the topic the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your ",
  //     "topics": ["Movies", "Video Games", "Theme Parks", "TV Shows"]
  //   },
  //   "Star Wars 2": {
  //     "news":
  //         "Relevant new to the topic the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your ",
  //     "topics": ["Movies", "Video Games", "Theme Parks", "TV Shows"]
  //   },
  //   "Star Wars 3": {
  //     "news":
  //         "Relevant new to the topic the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your ",
  //     "topics": ["Movies", "Video Games", "Theme Parks", "TV Shows"]
  //   },
  //   "Star Wars 4": {
  //     "news":
  //         "Relevant new to the topic the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your ",
  //     "topics": ["Movies", "Video Games", "Theme Parks", "TV Shows"]
  //   },
  // };
  // Map<String, Map<String, dynamic>> _trendsUK = {
  //   "Arctic Monkeys": {
  //     "news":
  //         "Relevant new to the topic the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your ",
  //     "topics": ["Music", "Concerts", "Theme Parks", "TV Shows", "Punk"]
  //   },
  //   "Arctic Monkeys 2": {
  //     "news":
  //         "Relevant new to the topic the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your ",
  //     "topics": ["Music", "Concerts", "Theme Parks", "TV Shows", "Punk"]
  //   },
  // };
  Map<int, Map<String, dynamic>> _itemsAnalysis = {};
  List<ImageGen> _itemsImages = [];
  //   ImageGen(
  //     id: 23324,
  //     trend: 'Topic 1',
  //     date: '12/10/23',
  //     prompt: 'Draw me a something',
  //     image_data: ["2048x2048", "DALL-E 3", "assets/images/example.png"],
  //   ),
  //   ImageGen(
  //     id: 23325,
  //     trend: 'Topic 1',
  //     date: '12/10/23',
  //     prompt: 'Draw me a something',
  //     image_data: ["1024x1024", "DALL-E 3", "assets/images/example2.png"],
  //   ),
  //   ImageGen(
  //     id: 23326,
  //     trend: 'Topic 1',
  //     date: '', // Assuming an empty string for date as it is not provided
  //     prompt: '', // Assuming an empty string for prompt as it is not provided
  //     image_data: ["2048x2048", "DALL-E 3", "assets/images/example3.png"],
  //   ),
  //   ImageGen(
  //     id: 23327,
  //     trend: 'Topic 3',
  //     date: '', // Assuming an empty string for date as it is not provided
  //     prompt: '', // Assuming an empty string for prompt as it is not provided
  //     image_data: ["2048x2048", "DALL-E 3", "assets/images/example.png"],
  //   ),
  //   ImageGen(
  //     id: 23328,
  //     trend: 'Topic 2',
  //     date: '', // Assuming an empty string for date as it is not provided
  //     prompt: '', // Assuming an empty string for prompt as it is not provided
  //     image_data: ["2048x2048", "DALL-E 3", "assets/images/example2.png"],
  //   ),
  // ];

  // Map<int, Map<String, dynamic>> _itemsImages = {
  //   23324: {
  //     "resolution": "2048x2048",
  //     "engine": "DALL-E 3",
  //     "imgURL": "assets/images/example.png",
  //     "topic": "Topic 1",
  //     "date": "12/10/23",
  //     "prompt": "Draw me a something",
  //   },
  //   23325: {
  //     "resolution": "1024x1024",
  //     "engine": "DALL-E 3",
  //     "imgURL": "assets/images/example2.png",
  //     "topic": "Topic 1",
  //     "date": "12/10/23",
  //     "prompt": "Draw me a something",
  //   },
  //   23326: {
  //     "resolution": "2048x2048",
  //     "engine": "DALL-E 3",
  //     "imgURL": "assets/images/example3.png",
  //     "topic": "Topic 1",
  //   },
  //   23327: {
  //     "resolution": "2048x2048",
  //     "engine": "DALL-E 3",
  //     "imgURL": "assets/images/example.png",
  //     "topic": "Topic 3",
  //   },
  //   23328: {
  //     "resolution": "2048x2048",
  //     "engine": "DALL-E 3",
  //     "imgURL": "assets/images/example2.png",
  //     "topic": "Topic 2",
  //   },
  // };
  // Map<int, Map<String, dynamic>> _itemsPosts = {
  //   23324: {
  //     "resolution": "2048x2048",
  //     "engine": "DALL-E 3",
  //     "imgURL": "assets/images/example.png",
  //     "topic": "Topic 1",
  //     "description":
  //         "Experience the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your heart.",
  //     "hashtags": [
  //       "#one",
  //       "#two",
  //       "#one",
  //       "#two",
  //       "#one",
  //       "#two",
  //       "#one",
  //       "#two"
  //     ],
  //     "date": "12/10/23",
  //     "prompt":
  //         "Draw me a something, Draw me a something, Draw me a something, Draw me a something, Draw me a something, Draw me a something",
  //   },
  //   23325: {
  //     "resolution": "1024x1024",
  //     "engine": "DALL-E 3",
  //     "imgURL": "assets/images/example2.png",
  //     "topic": "Topic 1",
  //     "description":
  //         "Experience the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your heart.",
  //     "hashtags": ["#one", "#two", "#one", "#two"],
  //     "date": "12/10/23",
  //     "prompt": "Draw me a something, Draw me a something, Draw me a something",
  //   },
  //   23326: {
  //     "resolution": "2048x2048",
  //     "engine": "DALL-E 3",
  //     "imgURL": "assets/images/example3.png",
  //     "topic": "Topic 1",
  //     "description":
  //         "Experience the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your heart.",
  //     "hashtags": ["#one", "#two", "#one", "#two", "#one", "#two"],
  //     "date": "12/10/23",
  //     "prompt": "Draw me a something, Draw me a something",
  //   },
  //   23327: {
  //     "resolution": "2048x2048",
  //     "engine": "DALL-E 3",
  //     "imgURL": "assets/images/example.png",
  //     "topic": "Topic 3",
  //     "description":
  //         "Experience the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your heart.",
  //     "hashtags": ["#one", "#two"],
  //     "date": "12/10/23",
  //     "prompt":
  //         "Draw me a something, Draw me a something, Draw me a something, Draw me a something",
  //   },
  //   23328: {
  //     "resolution": "2048x2048",
  //     "engine": "DALL-E 3",
  //     "imgURL": "assets/images/example2.png",
  //     "topic": "Topic 2",
  //     "description":
  //         "Experience the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your heart.",
  //     "hashtags": ["#one", "#two", "#one", "#two"],
  //     "date": "12/10/23",
  //     "prompt": "Draw me a something",
  //   },
  // };
  List<PostGen> _itemsPosts = [];
  //   PostGen(
  //       id: 23324,
  //       trend: "Topic 1",
  //       date: "12/10/23",
  //       image_data: ["2048x2048", "DALL-E 3", "assets/images/example.png"],
  //       description:
  //           "Experience the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your heart.",
  //       hashtags: [
  //         "#one",
  //         "#two",
  //         "#one",
  //         "#two",
  //         "#one",
  //         "#two",
  //         "#one",
  //         "#two"
  //       ],
  //       prompt:
  //           "Draw me a something, Draw me a something, Draw me a something, Draw me a something, Draw me a something, Draw me a something",
  //       title: "", // Title is missing in the original data. Assuming empty.
  //       imageBytes: base64Decode("")),
  //   PostGen(
  //       id: 23325,
  //       trend: "Topic 1",
  //       date: "12/10/23",
  //       image_data: ["1024x1024", "DALL-E 3", "assets/images/example2.png"],
  //       description:
  //           "Experience the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your heart.",
  //       hashtags: ["#one", "#two", "#one", "#two"],
  //       prompt: "Draw me a something, Draw me a something, Draw me a something",
  //       title: "", // Title is missing in the original data. Assuming empty.
  //       imageBytes: base64Decode("")),
  //   PostGen(
  //       id: 23326,
  //       trend: "Topic 1",
  //       date: "12/10/23",
  //       image_data: ["2048x2048", "DALL-E 3", "assets/images/example3.png"],
  //       description:
  //           "Experience the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your heart.",
  //       hashtags: ["#one", "#two", "#one", "#two", "#one", "#two"],
  //       prompt: "Draw me a something, Draw me a something",
  //       title: "", // Title is missing in the original data. Assuming empty.
  //       imageBytes: base64Decode("")),
  //   PostGen(
  //       id: 23327,
  //       trend: "Topic 3",
  //       date: "12/10/23",
  //       image_data: ["2048x2048", "DALL-E 3", "assets/images/example.png"],
  //       description:
  //           "Experience the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your heart.",
  //       hashtags: ["#one", "#two"],
  //       prompt:
  //           "Draw me a something, Draw me a something, Draw me a something, Draw me a something",
  //       title: "", // Title is missing in the original data. Assuming empty.
  //       imageBytes: base64Decode("")),
  //   PostGen(
  //       id: 23328,
  //       trend: "Topic 2",
  //       date: "12/10/23",
  //       image_data: ["2048x2048", "DALL-E 3", "assets/images/example2.png"],
  //       description:
  //           "Experience the unforgettable journey of love and self-discovery in 'Every Summer After' by Carley Fortune. Get lost in the compelling story of a summer romance that will warm your heart.",
  //       hashtags: ["#one", "#two", "#one", "#two"],
  //       prompt: "Draw me a something",
  //       title: "", // Title is missing in the original data. Assuming empty.
  //       imageBytes: base64Decode("")),
  // ];

  List<String> _regions = ['canada', 'united_states', 'united_kingdom'];

  List<ImageGen> get itemsImages => _itemsImages;
  List<PostGen> get itemsPosts => _itemsPosts;
  Map<int, Map<String, dynamic>> get itemsAnalysis => _itemsAnalysis;

  List<Trend> _trendList = [];
  List<ImageGen> _imagesList = [];
  List<PostGen> _postsList = [];

  List<Trend> getCurrentRegion() {
    switch (_selectedRegion) {
      case 0:
        return _trendsCanada;
      case 1:
        return _trendsUS;
      case 2:
        return _trendsUK;
      default:
        return [];
    }
  }

  int getAmountOfTrends() {
    return _trendsCanada.length + _trendsUK.length + _trendsUS.length;
  }

  void setRegion(index) {
    _selectedRegion = index;
    notifyListeners();
  }

  void regenrateImage(id) {}
  void generateVariations(id) {}
  void acceptTopic(topic) {
    generateImg(topic);
    void removeItemById(List<Trend> items, String topic) {
      items.removeWhere((item) => item.trend == topic);
    }

    try {
      switch (_selectedRegion) {
        case 0:
          removeItemById(_trendsCanada, topic);
        case 1:
          removeItemById(_trendsUS, topic);
        case 2:
          removeItemById(_trendsUK, topic);
      }
    } catch (e) {}
    notifyListeners();
  }

  void acceptImagePhase(id) {
    generatePost(id);
    void removeItemById(List<ImageGen> items, int itemId) {
      items.removeWhere((item) => item.id == itemId);
    }

    removeItemById(_itemsImages, id);
    notifyListeners();
  }

  void refreashImagePhase(id) {
    regenerateImg(id);
    void removeItemById(List<ImageGen> items, int itemId) {
      items.removeWhere((item) => item.id == itemId);
    }

    removeItemById(_itemsImages, id);
    notifyListeners();
  }

  void declineImagePhase(id) {
    removeImage(id);
    void removeItemById(List<ImageGen> items, int itemId) {
      items.removeWhere((item) => item.id == itemId);
    }

    removeItemById(_itemsImages, id);
    notifyListeners();
  }

  void acceptPostPhase(id) {
    uploadPost(id);
    void removeItemById(List<PostGen> items, int itemId) {
      items.removeWhere((item) => item.id == itemId);
    }

    removeItemById(_itemsPosts, id);
    notifyListeners();
  }

  void declinePostPhase(id) {
    removePost(id);
    void removeItemById(List<PostGen> items, int itemId) {
      items.removeWhere((item) => item.id == itemId);
    }

    removeItemById(_itemsPosts, id);
    notifyListeners();
  }

  void refreashImages() async {
    _itemsImages = [];
    String imagesList = await getImages();
    convertListOfImagesToObjects(imagesList);
    notifyListeners();
  }

  void refreashPosts() async {
    _itemsPosts = [];
    String postsList = await getPosts();
    convertListOfPostsToObjects(postsList);
    notifyListeners();
  }

  void refreashTrends() async {
    _trendsCanada = [];
    _trendsUK = [];
    _trendsUS = [];
    String trendslist = await getTrends();
    convertListOfTrendsToObjects(trendslist);
    notifyListeners();
  }

  void convertListOfTrendsToObjects(String jsonData) {
    final parsedJson = json.decode(jsonData);
    final data = parsedJson['data'];
    final canada = data['canada'];
    final unitedStates = data['united_states'];
    final unitedKingdom = data['united_kingdom'];
    List<Trend> canadaTrends = [];
    List<Trend> ukTrends = [];
    List<Trend> usTrends = [];

    if (canada != null) {
      canada.forEach((id, content) {
        Trend item = Trend.fromJson(content);
        _trendsCanada.add(item);
      });
    }
    if (unitedStates != null) {
      unitedStates.forEach((id, content) {
        Trend item = Trend.fromJson(content);
        _trendsUS.add(item);
      });
    }
    if (unitedKingdom != null) {
      unitedKingdom.forEach((id, content) {
        Trend item = Trend.fromJson(content);
        _trendsUK.add(item);
      });
    }
  }

  void convertListOfImagesToObjects(String jsonData) {
    final parsedJson = json.decode(jsonData);
    final data = parsedJson['data'];
    List<ImageGen> imageItemList = [];

    if (data != null) {
      data.forEach((id, content) {
        ImageGen item = ImageGen.fromJson(content, int.parse(id));
        _itemsImages.add(item);
      });
    }
  }

  void convertListOfPostsToObjects(String jsonData) {
    final parsedJson = json.decode(jsonData);
    final data = parsedJson['data'];
    List<PostGen> postsItemList = [];

    if (data != null) {
      data.forEach((id, content) {
        PostGen item = PostGen.fromJson(content, int.parse(id));
        _itemsPosts.add(item);
      });
    }
  }
}
