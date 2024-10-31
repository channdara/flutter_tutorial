import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'bloc/story_video_bloc.dart';
import 'bloc/story_video_bloc_state.dart';
import 'story_video.dart';

class StoryVideoScreen extends StatefulWidget {
  const StoryVideoScreen({super.key});

  @override
  State<StoryVideoScreen> createState() => _StoryVideoScreenState();
}

class _StoryVideoScreenState extends State<StoryVideoScreen> {
  @override
  void initState() {
    super.initState();
    bloc.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: bloc,
        buildWhen: (p, c) => c is StateBlocLoadedData,
        builder: (context, state) {
          return PreloadPageView.builder(
            controller: bloc.preloadPageController,
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            itemCount: bloc.videos.length,
            itemBuilder: (context, index) {
              return StoryWidget(item: bloc.videos[index]);
            },
            onPageChanged: bloc.onPageChanged,
          );
        },
      ),
    );
  }
}

class StoryWidget extends StatefulWidget {
  const StoryWidget({super.key, required this.item});

  final StoryVideo item;

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: widget.item.controller,
      showVideoProgressIndicator: true,
      onReady: bloc.onReady,
      onEnded: (data) {
        if (widget.item.repeatCount >= 3) {
          widget.item.repeatCount = 0;
          bloc.preloadPageController.nextPage(
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
          );
        }
        widget.item.repeatCount++;
        widget.item.controller.seekTo(Duration.zero);
      },
      bottomActions: const [
        CurrentPosition(),
        ProgressBar(isExpanded: true),
        RemainingDuration(),
      ],
    );
  }
}
