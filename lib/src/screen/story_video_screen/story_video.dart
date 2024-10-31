import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final List<String> kVideos = [
  'https://www.youtube.com/shorts/8gvqgfHBiPY',
  'https://www.youtube.com/shorts/WgdvQXb3BiQ',
  'https://www.youtube.com/shorts/eZtyhIM6glc',
  'https://www.youtube.com/shorts/LBGTM8lBZvs',
  'https://www.youtube.com/shorts/L4EXmnTq99o',
  'https://www.youtube.com/shorts/GuXpxb2O8ko',
  'https://www.youtube.com/shorts/gQxke0jYFDw',
  'https://www.youtube.com/shorts/24-dLbjWrVY',
  'https://www.youtube.com/shorts/KerMjJxhovg',
  'https://www.youtube.com/shorts/YKYYFiE2kk4',
  'https://www.youtube.com/shorts/8gvqgfHBiPY',
  'https://www.youtube.com/shorts/WgdvQXb3BiQ',
  'https://www.youtube.com/shorts/eZtyhIM6glc',
  'https://www.youtube.com/shorts/LBGTM8lBZvs',
  'https://www.youtube.com/shorts/L4EXmnTq99o',
  'https://www.youtube.com/shorts/GuXpxb2O8ko',
  'https://www.youtube.com/shorts/gQxke0jYFDw',
  'https://www.youtube.com/shorts/24-dLbjWrVY',
  'https://www.youtube.com/shorts/KerMjJxhovg',
  'https://www.youtube.com/shorts/YKYYFiE2kk4',
];

class StoryVideo {
  StoryVideo(
    this.url,
    this.controller,
  );

  final String url;
  final YoutubePlayerController controller;

  int repeatCount = 0;
}
