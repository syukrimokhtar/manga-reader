import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:manga_reader/library/sm.dart';

class HomeController extends GetxController {

  //logging
  final _talker = Sm.instance.talker;

  var imageList = [].obs;
  var isLoading = false.obs;
  var chapterList = [].obs;
  var title = "".obs;
  var oldTitle = "".obs;
  var selected = "home".obs;

  TextEditingController inputController = TextEditingController(text: "https://w71.1piecemanga.com/");


  void fetchChapters() async {

    isLoading(true);
    chapterList.clear();
    imageList.clear();
    title('');
    String url = inputController.text;
    
    var chapterRegExp = RegExp(r'(?<=comic-thumb-title">)(.*)(?=</a></div>)');

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {

      var body = response.body;

      //collect hyperlink
      var chapters = chapterRegExp.allMatches(body).map((e) => e.group(0)).toList();
      for(var chapter in chapters) {
        var ch = parse(chapter);
        List<dom.Element> els = ch.getElementsByTagName("a");
        for(var el in els) {
          String url = "${el.attributes["href"]}";
          String title = el.innerHtml;
          chapterList.add({
            "title": title,
            "url": url
          });
        }
      }

      //get title
      var titleRegExp = RegExp(r'(?<=<title>)(.*)(?=</title>)');
      var titles = titleRegExp.allMatches(body).map((e) => e.group(0)).toList();
      for(var t in titles) {
        title(t);
        oldTitle(t);
      }

    }

  isLoading(false);
  }

  void fetchChapter(url, title) async {

    isLoading(true);
    imageList.clear();
    this.title(title);
    
    var imageRegExp = RegExp(r'(?<=<img)(.*)');

    _talker.debug("url: $url");
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {

      var body = response.body;

      //collect image
      var images = imageRegExp.allMatches(body).map((e) => e.group(1)).toList();
      _talker.debug(images.length);
      for(var imageUrl in images) {
        String img = "<img $imageUrl />";
        var ch = parse(img);
        List<dom.Element> els = ch.getElementsByTagName("img");
        for(var el in els) {
          String url = "${el.attributes["src"]}";
          imageList.add(url);
        }
      }

    }

  isLoading(false);
  }

  void clear() {
    title(oldTitle.value);
    imageList.clear();
  }
  
}