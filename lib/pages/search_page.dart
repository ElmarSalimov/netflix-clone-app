import 'package:flutter/material.dart';
import 'package:netflix_clone/services/api.dart';
import 'package:netflix_clone/widgets/search_page_bar.dart';
import 'package:netflix_clone/models/search_model.dart';
import 'package:netflix_clone/widgets/search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  Future<SearchModel>? movieSearchResults;
  Future<SearchModel>? tvShowSearchResults;
  ApiService apiServices = ApiService();

  @override
  void initState() {
    super.initState();
    controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    controller.removeListener(_onSearchChanged);
    controller.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      if (controller.text.isNotEmpty) {
        movieSearchResults = apiServices.getSearchedMovie(controller.text);
        tvShowSearchResults = apiServices.getSearchedTvShow(controller.text);
      } else {
        movieSearchResults = null;
        tvShowSearchResults = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: SearchPageBar(
              minExtent: 70,
              maxExtent: 70,
              controller: controller,
            ),
          ),
          SliverToBoxAdapter(
            child: SearchWidget(
              controller: controller,
              movieSearchResults: movieSearchResults,
              tvShowSearchResults: tvShowSearchResults,
            ),
          ),
        ],
      ),
    );
  }

  bool get wantKeepAlive => true;
}
