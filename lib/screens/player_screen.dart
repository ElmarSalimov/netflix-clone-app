import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:netflix_clone/services/api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerScreen extends StatefulWidget {
  final int movieId;

  const PlayerScreen({super.key, required this.movieId});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  ApiService apiServices = ApiService();
  YoutubePlayerController? _controller;
  bool _isPlayerReady = false;
  bool _isLoading = true;
  bool _isPlaying = false;
  bool _showButton = true;
  Timer? _hideButtonTimer;

  @override
  void initState() {
    super.initState();
    _loadTrailer();
    _resetHideButtonTimer();
  }

  @override
  void dispose() {
    _controller?.removeListener(_playerListener);
    _controller?.dispose();
    _hideButtonTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadTrailer() async {
    try {
      final trailerKey = await apiServices.getMovieTrailer(widget.movieId);
      if (trailerKey != null) {
        setState(() {
          _controller = YoutubePlayerController(
            initialVideoId: trailerKey,
            flags: const YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
              hideControls: true,
              forceHD: true,
            ),
          )..addListener(_playerListener);

          _isLoading = false;
          _isPlaying = true;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      log('Error fetching trailer: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _playerListener() {
    if (_controller != null && _controller!.value.isReady && !_isPlayerReady) {
      setState(() {
        _isPlayerReady = true;
      });
    }

    if (_controller != null && _isPlayerReady) {
      setState(() {
        _isPlaying = _controller!.value.isPlaying;
      });
    }
  }

  void _togglePlayPause() {
    if (_controller != null) {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
      _showButtonOnInteraction();
    }
  }

  void _resetHideButtonTimer() {
    _hideButtonTimer?.cancel();
    _hideButtonTimer = Timer(const Duration(seconds: 2), () {
      setState(() {
        _showButton = false;
      });
    });
  }

  void _showButtonOnInteraction() {
    setState(() {
      _showButton = true;
    });
    _resetHideButtonTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (_controller != null) {
              _controller!.pause(); // Ensure video is paused before navigating back
            }
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "Watch Trailer",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: _showButtonOnInteraction,
        child: Stack(
          children: [
            // Player
            Center(
              child: _isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    )
                  : _controller != null
                      ? YoutubePlayer(controller: _controller!)
                      : const Text(
                          'No trailer available',
                          style: TextStyle(color: Colors.white),
                        ),
            ),
            // Play/Pause Button
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: MediaQuery.of(context).size.width * 0.4,
              child: AnimatedOpacity(
                opacity: _showButton ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: IconButton(
                  iconSize: 60.0,
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  onPressed: _togglePlayPause,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
