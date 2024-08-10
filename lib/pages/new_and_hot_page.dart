import 'package:flutter/material.dart';
import 'package:netflix_clone/services/api.dart';
import 'package:netflix_clone/widgets/new_and_hot_bar.dart';
import 'package:netflix_clone/widgets/new_and_hot_widget.dart';

class NewAndHotPage extends StatefulWidget {
  const NewAndHotPage({super.key});

  @override
  State<NewAndHotPage> createState() => _NewAndHotPageState();
}

class _NewAndHotPageState extends State<NewAndHotPage> {
  ApiService apiServices = ApiService();
  final ScrollController controller = ScrollController();
  bool isFirst = true;
  bool isSecond = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.dispose();
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (controller.offset < 10800) {
      setState(() {
        isFirst = true;
        isSecond = false;
      });
    } else if (controller.offset > 10800) {
      setState(() {
        isFirst = false;
        isSecond = true;
      });
    }
  }

  void _updateFilter(bool selected) async {
    setState(() {
      isFirst = selected;
      isSecond = !selected;
    });
    controller.removeListener(_scrollListener);
    await controller.animateTo(
      isSecond ? 10800 : 0,
      duration: const Duration(milliseconds: 300), // Duration of the animation
      curve: Curves.easeInOut, // Curve of the animation
    );
    controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: NewAndHotBar(
              minExtent: 110,
              maxExtent: 110,
              isFirst: isFirst,
              isSecond: isSecond,
              onFilterChanged: _updateFilter),
        ),
        const SliverToBoxAdapter(
          child: NewAndHotWidget(),
        ),
      ],
    );
  }

  bool get wantKeepAlive => true;
}
