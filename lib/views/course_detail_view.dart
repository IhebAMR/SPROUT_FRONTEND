// lib/views/course_detail_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart'; // For JavascriptMode
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import '../models/course.dart';
import '../viewmodels/course_viewmodel.dart';

class CourseDetailView extends StatefulWidget {
  final Course course;

  const CourseDetailView({Key? key, required this.course}) : super(key: key); // Add key parameter

  @override
  _CourseDetailViewState createState() => _CourseDetailViewState();
}

class _CourseDetailViewState extends State<CourseDetailView> {
  late VideoPlayerController _controller;
  WebViewController? _webViewController;
  bool _isVideoLoading = false;
  String? _videoError;

  @override
  void initState() {
    super.initState();
    // Do not call _playVideo here to avoid SnackBar before build
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _playVideo(widget.course.videoUrl); // Safe to call here after widget is built
  }

  @override
  void dispose() {
    _controller.dispose();
    // No dispose needed for WebViewController
    super.dispose();
  }

  Future<void> _playVideo(String? videoUrl) async {
    _controller?.dispose();
    if (_webViewController != null) {
      await _webViewController!.clearCache(); // Reset WebView
    }
    setState(() {
      _isVideoLoading = true;
      _videoError = null;
    });

    if (videoUrl != null && videoUrl.isNotEmpty) {
      if (videoUrl.contains('youtube.com')) {
        final videoId = Uri.parse(videoUrl).queryParameters['v'];
        if (videoId != null && videoId.isNotEmpty) {
          _webViewController = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse('https://www.youtube.com/embed/$videoId'));
          setState(() {
            _isVideoLoading = false;
          });
        } else {
          setState(() {
            _isVideoLoading = false;
            _videoError = 'Invalid YouTube URL';
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(_videoError!)),
            );
          });
        }
      } else {
        _controller = VideoPlayerController.network(videoUrl)
          ..initialize().then((_) {
            setState(() {
              _isVideoLoading = false;
            });
            _controller.play();
          }).catchError((error) {
            setState(() {
              _isVideoLoading = false;
              _videoError = 'Failed to load video: $error';
            });
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(_videoError!)),
              );
            });
          });
      }
    } else {
      setState(() {
        _isVideoLoading = false;
        _videoError = 'No video URL available';
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_videoError!)),
        );
      });
    }
  }

  void _toggleVideo() {
    if (_controller != null && _controller!.value.isPlaying) {
      _controller!.pause(); // Replaced ?. with ! since _controller is late
    } else if (_controller != null) {
      _controller!.play();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final courseViewModel = Provider.of<CourseViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.title),
        backgroundColor: Colors.teal[700],
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_isVideoLoading)
                const Center(child: CircularProgressIndicator(color: Colors.teal)),
              if (_videoError != null)
                Center(child: Text(_videoError!, style: TextStyle(color: Colors.red))),
              if (!_isVideoLoading && _videoError == null && _controller != null && _controller!.value.isInitialized)
                Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: VideoPlayer(_controller!),
                    ),
                    VideoProgressIndicator(
                      _controller!,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        playedColor: Colors.teal,
                        bufferedColor: Colors.teal[100]!,
                        backgroundColor: Colors.grey[300]!,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.teal,
                          ),
                          onPressed: _toggleVideo,
                        ),
                        IconButton(
                          icon: const Icon(Icons.stop, color: Colors.teal),
                          onPressed: () {
                            _controller!.pause();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              if (!_isVideoLoading && _videoError == null && _webViewController != null)
                SizedBox(
                  height: 300,
                  child: WebViewWidget(controller: _webViewController!),
                ),
              const SizedBox(height: 20),
              Text(
                'Title: ${widget.course.title}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Description: ${widget.course.description}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(
                'Duration: ${widget.course.duration} hours',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[700]),
                child: const Text('Back to Courses'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}