// lib/views/course_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart'; // For JavascriptMode
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import '../viewmodels/course_viewmodel.dart';

class CourseView extends StatefulWidget {
  const CourseView({Key? key}) : super(key: key); // Add key parameter

  @override
  _CourseViewState createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  VideoPlayerController? _controller;
  WebViewController? _webViewController; // Use WebViewController
  bool _isVideoLoading = false;
  String? _videoError;

  @override
  void dispose() {
    _controller?.dispose();
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_videoError!)),
          );
        }
      } else {
        _controller = VideoPlayerController.network(videoUrl)
          ..initialize().then((_) {
            setState(() {
              _isVideoLoading = false;
            });
            _controller?.play();
          }).catchError((error) {
            setState(() {
              _isVideoLoading = false;
              _videoError = 'Failed to load video: $error';
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(_videoError!)),
            );
          });
      }
    } else {
      setState(() {
        _isVideoLoading = false;
        _videoError = 'No video URL available';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_videoError!)),
      );
    }
  }

  void _toggleVideo() {
    if (_controller != null) {
      setState(() {
        if (_controller!.value.isPlaying) {
          _controller?.pause();
        } else {
          _controller?.play();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final courseViewModel = Provider.of<CourseViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        elevation: 4,
        backgroundColor: Colors.teal[700],
      ),
      body: courseViewModel.isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 40),
                      const SizedBox(height: 10),
                      Text('Error: ${courseViewModel.error}', style: const TextStyle(color: Colors.red)),
                      TextButton(
                        onPressed: () => courseViewModel.fetchAllCourses(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : courseViewModel.courses.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.video_library_outlined, color: Colors.grey, size: 40),
                          const SizedBox(height: 10),
                          const Text('No courses found. Click refresh to load.'),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () => courseViewModel.fetchAllCourses(),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[700]),
                            child: const Text('Refresh'),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: courseViewModel.courses.length,
                      itemBuilder: (context, index) {
                        final course = courseViewModel.courses[index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: ExpansionTile(
                            title: Text(
                              course.title,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '${course.description} - ${course.duration} hours',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            leading: const Icon(Icons.play_circle_outline, color: Colors.teal),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (_isVideoLoading)
                                      const Center(child: CircularProgressIndicator(color: Colors.teal)),
                                    if (_videoError != null)
                                      Center(
                                        child: Text(_videoError!, style: TextStyle(color: Colors.red)),
                                      ),
                                    if (_controller != null && _controller!.value.isInitialized)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 200,
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
                                                  _controller!.value.isPlaying
                                                      ? Icons.pause
                                                      : Icons.play_arrow,
                                                  color: Colors.teal,
                                                ),
                                                onPressed: _toggleVideo,
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.stop, color: Colors.teal),
                                                onPressed: () {
                                                  _controller?.pause();
                                                  setState(() {
                                                    _controller = null;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    if (_webViewController != null)
                                      SizedBox(
                                        height: 200,
                                        child: WebViewWidget(controller: _webViewController!),
                                      ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Description: ${course.description}',
                                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            onExpansionChanged: (expanded) {
                              if (expanded) {
                                courseViewModel.fetchCourseById(course.id);
                                _playVideo(course.videoUrl);
                              } else if (_controller != null) {
                                _controller?.pause();
                              }
                            },
                          ),
                        );
                      },
                    ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => courseViewModel.fetchAllCourses(),
            backgroundColor: Colors.teal[700],
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Create Course feature coming soon!')),
              );
            },
            backgroundColor: Colors.teal[500],
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}