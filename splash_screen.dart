// lib/screens/splash_screen.dart (Splash Screen with Video)

import 'package:flutter/material.dart';
import 'home_screen.dart'; 
import 'package:video_player/video_player.dart'; // Zaroori

const Color darkBackground = Color(0xFF1E1E1E);

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // 'assets/opening_animation.mp4' file ka path sahi hona chahiye
    _controller = VideoPlayerController.asset('assets/opening_animation.mp4') 
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(false); 
        _controller.play();
      });

    _controller.addListener(_videoListener);
  }

  void _videoListener() {
    if (_controller.value.isInitialized && _controller.value.position >= _controller.value.duration) {
      _controller.removeListener(_videoListener);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Image.asset('assets/logo.png', height: 200),
      ),
    );
  }
}