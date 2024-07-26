import 'package:flutter/material.dart';
import 'package:netflix_clone/provider/movie_provider.dart';
import 'package:netflix_clone/widgets/home_page_bar.dart';
import 'package:netflix_clone/widgets/slide_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ScrollController controller = ScrollController();
  bool isMovie = true;
  bool isTvShow = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieProvider>().fetchAll();
    });

    controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.dispose();
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (controller.offset < 1000) {
      setState(() {
        isMovie = true;
        isTvShow = false;
      });
    } else if (controller.offset > 1000) {
      setState(() {
        isMovie = false;
        isTvShow = true;
      });
    }
  }

  void _updateFilter(bool movieSelected) async {
    setState(() {
      isMovie = movieSelected;
      isTvShow = !movieSelected;
    });
    controller.removeListener(_scrollListener);
    await controller.animateTo(
      isTvShow ? 1000 : 0,
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
          delegate: HomePageBar(
            minExtent: 100,
            maxExtent: 100,
            isMovie: isMovie,
            isTvShow: isTvShow,
            onFilterChanged: _updateFilter,
          ),
        ),
        SliverToBoxAdapter(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              const offsetAnimation = Offset(1, 0);
              const scaleAnimation = 0.8;
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: scaleAnimation, end: 1.0)
                      .animate(animation),
                  child: SlideTransition(
                    position:
                        Tween<Offset>(begin: offsetAnimation, end: Offset.zero)
                            .animate(animation),
                    child: child,
                  ),
                ),
              );
            },
            child: const SlideWidget(),
          ),
        ),
      ],
    );
  }
}
