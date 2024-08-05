import 'package:flutter/material.dart';
import 'package:netflix_clone/widgets/everyone_watching.dart';
import 'package:netflix_clone/widgets/new_and_hot_slide.dart';

class NewAndHotWidget extends StatefulWidget {
  const NewAndHotWidget({
    super.key,
  });

  @override
  State<NewAndHotWidget> createState() => _NewAndHotWidgetState();
}

class _NewAndHotWidgetState extends State<NewAndHotWidget> {
  @override
  Widget build(BuildContext context) {
    return const Column(children: [NewAndHotSlide(), EveryoneWatchingSlide()]);
  }
}
