import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _videoFile;
  bool _uploading = false;

  final _picker = ImagePicker();

  Future<void> _pickVideo() async {
    final XFile? picked = await _picker.pickVideo(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _videoFile = File(picked.path));
    }
  }

  Future<void> _uploadVideo() async {
    if (_videoFile == null || _titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a video and add a title')),
      );
      return;
    }

    setState(() => _uploading = true);
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must be signed in to upload')),
        );
        setState(() => _uploading = false);
        return;
      }

      // Generate unique file name
      final fileName = '${user.id}_${DateTime.now().millisecondsSinceEpoch}.mp4';
      final fileBytes = await _videoFile!.readAsBytes();

      // Upload to Supabase Storage
      await Supabase.instance.client.storage
          .from('videos')
          .uploadBinary(fileName, fileBytes);

      // Get public URL
      final videoUrl = Supabase.instance.client.storage
          .from('videos')
          .getPublicUrl(fileName);

      // Insert metadata into videos table
      await Supabase.instance.client.from('videos').insert({
        'user_id': user.id,
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'video_url': videoUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Video uploaded successfully!')),
      );
      Navigator.pop(context); // Go back to feed
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      setState(() => _uploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        title: const Text('Upload Video'),
        backgroundColor: const Color(0xFF0A0E21),
        foregroundColor: const Color(0xFF00E5FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickVideo,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF00E5FF), width: 2),
                ),
                child: Center(
                  child: _videoFile != null
                      ? const Icon(Icons.check_circle, color: Colors.green, size: 48)
                      : const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.video_library, color: Color(0xFF00E5FF), size: 48),
                            SizedBox(height: 8),
                            Text('Tap to select video', style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF00E5FF)),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF00E5FF)),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _uploading ? null : _uploadVideo,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E5FF),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: _uploading
                  ? const CircularProgressIndicator(color: Color(0xFF0A0E21))
                  : const Text('Upload', style: TextStyle(fontSize: 18, color: Color(0xFF0A0E21))),
            ),
          ],
        ),
      ),
    );
  }
}
