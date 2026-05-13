import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
class StorageService {//this class is used to manage the storage of the application and also to upload the profile picture to the supabase storage and also to delete the profile picture from the supabase storage
final SupabaseClient _supabase = Supabase.instance.client;
static const String _bucketName = 'student_profiles';
// Pick image from gallery or camera
static Future<File?> pickImage(ImageSource source) async {
final picker = ImagePicker();
try {// Pick and optionally resize/compress the image to save bandwidth
final pickedFile = await picker.pickImage(
source: source,
maxWidth: 1024, // Resize to save bandwidth
maxHeight: 1024,
imageQuality: 85, // Compress to 85% quality
);
return pickedFile != null ? File(pickedFile.path) : null;
} catch (e) {// ignore: avoid_print
return null;
}
}
// Upload profile picture to Supabase Storage
Future<String?> uploadProfilePicture(String studentId, File imageFile) async {
try {// Create unique file name using student ID and timestamp to avoid collisions
// Create unique file name
final fileExt = imageFile.path.split('.').last;
final fileName = '$studentId/${DateTime.now().millisecondsSinceEpoch}.$fileExt';
// Upload to bucket
await _supabase.storage.from(_bucketName).upload(
fileName,
imageFile,
fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
);
// Get public URL (since bucket is public)
return _supabase.storage.from(_bucketName).getPublicUrl(fileName);
} catch (e) {// ignore: avoid_print
// ignore: avoid_print
print('Upload error: $e');
return null;
}
}
// Delete profile picture
Future<bool> deleteProfilePicture(String imageUrl) async {
try {// Extract file path from URL
// Extract file path from URL
final uri = Uri.parse(imageUrl);
final pathSegments = uri.pathSegments;
final filePath = pathSegments.sublist(3).join('/');
await _supabase.storage.from(_bucketName).remove([filePath]);
return true;
} catch (e) {// ignore: avoid_print
return false;
}
}
}