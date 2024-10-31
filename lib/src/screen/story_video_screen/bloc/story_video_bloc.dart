import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../story_video.dart';
import 'story_video_bloc_state.dart';

final StoryVideoBloc bloc = StoryVideoBloc();

class StoryVideoBloc extends Cubit<StateBloc> {
  StoryVideoBloc() : super(StateBlocInit());

  late PreloadPageController preloadPageController;

  List<StoryVideo> videos = [];
  int previousIndex = 0;

  void initState() {
    preloadPageController = PreloadPageController();
    _generateStoryVideoData();
  }

  void dispose() {
    preloadPageController.dispose();
    videos.forEach((action) => action.controller.dispose());
    close();
  }

  void onPageChanged(int index) {
    videos[previousIndex].controller.pause();
    previousIndex = index;
    Future.delayed(const Duration(milliseconds: 100), () {
      videos[index].controller.play();
    });
  }

  void onReady() {}

  void _generateStoryVideoData() {
    videos = List.generate(kVideos.length, (index) {
      final url = kVideos[index];
      final controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url) ?? '',
        flags: YoutubePlayerFlags(
          enableCaption: false,
          disableDragSeek: true,
          autoPlay: index == 0,
        ),
      );
      return StoryVideo(url, controller);
    });
    emit(StateBlocLoadedData());
  }
}
