import 'package:flutter/material.dart';
import 'package:netflix_clone/widgets/search_page_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
            pinned: true,
            delegate: SearchPageBar(minExtent: 100, maxExtent: 100)),
      ],
    );
  }
}
