import 'package:flutter/material.dart';
import 'package:flutter_api_demo/models/api/utils/APIClient.dart';
import 'package:flutter_api_demo/models/api/entities/Shop.dart';
import 'package:flutter_api_demo/Widgets/ShowLoading.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoadingComplated = false;
  List<Shop> _shops = [];

  @override
  void initState() {
    super.initState();

    APIClient().getGourmet().then((response) {
      _shops.addAll(response.results.shop);
    }).catchError((err) {
      //エラー時の処理
      print(err.toString());
    }).whenComplete(() => isLoadingComplated = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    if (isLoadingComplated) {
      return Center(child: _buildShops(context));
    } else {
      return Center(
        child: ShowLoading(),
      );
    }
  }

  Widget _buildShops(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0), //セパレートの左にスペースを開ける
      itemCount: _shops.length,
      itemBuilder: (context, i) {
        return _buildShopRow(_shops[i]);
      },
    );
  }

  Widget _buildShopRow(Shop shop) {
    return Container(
        decoration: BoxDecoration(
            border:
                new Border(bottom: BorderSide(width: 0.5, color: Colors.grey))),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(shop.genre.name),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                shop.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Image(
                  image: NetworkImage(shop.photo.mobile.large),
                  width: 168,
                  height: 168,
                )),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(shop.budget.average,
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                      ),
                      Text(shop.open,
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                      ),
                      Text(shop.access,
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                      ),
                      Text(
                        shop.address,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
          ],
        ));
  }
}
