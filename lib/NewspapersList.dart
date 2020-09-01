import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_item.dart';

import 'Item.dart';

class NewspapersList extends StatefulWidget {
  final String title;

  const NewspapersList({this.title});
  @override
  _NewspapersListState createState() => _NewspapersListState();
}

class _NewspapersListState extends State<NewspapersList> {
  Future<List<RssItem>> itemList;
  String url = "https://vnexpress.net/rss/tin-moi-nhat.rss";
  int length = 0;

  ListTile makeListTitle(String subject, String newURL) => ListTile(
        title: Text(subject),
        onTap: () {
          url = newURL;
          var _itemList = Item.browse(url);
          setState(() {
            itemList = _itemList;
            Navigator.pop(context);
          });
        },
      );

  @override
  void initState() {
    super.initState();
    itemList = Item.browse(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                var _itemList = Item.browse(url);
                setState(() {
                  itemList = _itemList;
                });
              })
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            makeListTitle(
                "Trang chủ", "https://vnexpress.net/rss/tin-moi-nhat.rss"),
            makeListTitle("Sức khỏe", "https://vnexpress.net/rss/suc-khoe.rss"),
            makeListTitle("Thế giới", "https://vnexpress.net/rss/the-gioi.rss"),
            makeListTitle("Đời sống", "https://vnexpress.net/rss/gia-dinh.rss"),
            makeListTitle("Thời sự", "https://vnexpress.net/rss/thoi-su.rss"),
            makeListTitle("Du lịch", "https://vnexpress.net/rss/du-lich.rss"),
            makeListTitle(
                "Kinh doanh", "https://vnexpress.net/rss/kinh-doanh.rss"),
            makeListTitle("Khoa học", "https://vnexpress.net/rss/khoa-hoc.rss"),
            makeListTitle("Startup", "https://vnexpress.net/rss/startup.rss"),
            makeListTitle("Số hóa", "https://vnexpress.net/rss/so-hoa.rss"),
            makeListTitle("Giải trí", "https://vnexpress.net/rss/giai-tri.rss"),
            makeListTitle("Xe", "https://vnexpress.net/rss/oto-xe-may.rss"),
            makeListTitle("Thể thao", "https://vnexpress.net/rss/the-thao.rss"),
            makeListTitle("Ý kiến", "https://vnexpress.net/rss/y-kien.rss"),
            makeListTitle(
                "Pháp luật", "https://vnexpress.net/rss/phap-luat.rss"),
            makeListTitle("Tâm sự", "https://vnexpress.net/rss/tam-su.rss"),
            makeListTitle("Giáo dục", "https://vnexpress.net/rss/giao-duc.rss"),
            makeListTitle("Cười", "https://vnexpress.net/rss/cuoi.rss"),
            makeListTitle(
                "Tin mới nhất", "https://vnexpress.net/rss/tin-moi-nhat.rss"),
            makeListTitle(
                "Tin nổi bật", "https://vnexpress.net/rss/tin-noi-bat.rss"),
            makeListTitle(
                "Tin xem nhiều", "https://vnexpress.net/rss/tin-xem-nhieu.rss"),
          ],
        ),
      ),
      body: FutureBuilder(
        future: itemList,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError)
                return Text("There was an error: ${snapshot.error}");
              var items = snapshot.data;

              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  Item item = Item(items[index]);
                  return ListTile(
                    leading: Image.network(item.src),
                    title: Text(item.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              item.time,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: items.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              );
          }
        },
      ),
    );
  }
}
