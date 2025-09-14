import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class InfinityScroll extends StatefulWidget {
  const InfinityScroll({super.key});

  @override
  State<InfinityScroll> createState() => _InfinityScrollState();
}

class _InfinityScrollState extends State<InfinityScroll> {
  ScrollController _scrollController = ScrollController();
  List<(int, int)> itemList = [];
  List<GlobalKey> _itemKeys = [];

  @override
  void initState() {
    // TODO: implement initState
    for (int i = 0; i < 20; i++) {
      itemList.add((i, Random().nextInt(200) + 100));
      _itemKeys.add(GlobalKey());
    }
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        debugPrint(
          "max: " + _scrollController.position.maxScrollExtent.toString(),
        );
        debugPrint("current: " + _scrollController.offset.toString());
        if ((_scrollController.position.maxScrollExtent - 1000) <= _scrollController.offset) {
          debugPrint("New Element Added!");
          int i = itemList.last.$1 + 1;
          int n = i + 20;
          for (i; i < n; i++) {
            itemList.add((i, Random().nextInt(200) + 100));
            _itemKeys.add(GlobalKey());
          }
          setState(() {});
        }
        if (itemList.length > 60) {
          // itemList.removeRange(0,40);
          // debugPrint("item removed");
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Infinity Scroll"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                debugPrint("removedvFirst-20");
                itemList.removeRange(0, 20);
              });
            },
            icon: Icon(Icons.cancel),
          ),
        ],
      ),
      body: SizedBox(
        height: 700,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: itemList.length,
          itemBuilder: (context, index) {
          // if(index!=0) print("ey : ${(_itemKeys[index==0? 0: index-1].currentContext?.findRenderObject() as RenderBox).size.height}");
            return Card(
            key: _itemKeys[index],
            color: Colors.red.shade100,
              child: GestureDetector(
                onTap: () {
                  // _scrollController.jumpTo(100);
                },
                child: Container(
                  height: itemList[index].$2.toDouble(),
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("index: ${itemList[index].$1}"),
                      Text("height: ${itemList[index].$2}"),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


