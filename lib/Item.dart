import 'dart:convert';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:http/http.dart' as http;

class Item {
  String title;
  String src;
  String description;
  String time;

  Item(RssItem item) {
    this.title = utf8.decode(item.title.runes.toList());
    int srcBegin = item.description.indexOf('src="') + 5;
    int srcEnd = item.description.indexOf('</a>', srcBegin) - 3;
    this.src = item.description.substring(srcBegin, srcEnd);
    int descriptionBegin = item.description.indexOf('</br>', srcEnd) + 5;
    int descriptionEnd = item.description.length - 1;
    this.description =
        item.description.substring(descriptionBegin, descriptionEnd);
    this.description = utf8.decode(description.runes.toList());
    this.time = getTime(item.pubDate);
  }

  String getTime(DateTime time) {
    if (DateTime.now().difference(time).inSeconds < 60)
      return "${DateTime.now().difference(time).inSeconds}s trước";
    else if (DateTime.now().difference(time).inMinutes < 60)
      return "${DateTime.now().difference(time).inMinutes}' trước";
    else if (DateTime.now().difference(time).inHours < 24)
      return "${DateTime.now().difference(time).inHours}h trước";
    else
      return "${DateTime.now().difference(time).inDays}d trước";
  }

  static Future<List<RssItem>> browse(String url) async {
    http.Response response = await http.get(url);
    String xmlString = response.body;
    var rssFeed = RssFeed.parse(xmlString);
    List<RssItem> _items = rssFeed.items;
    return _items;
  }
}
