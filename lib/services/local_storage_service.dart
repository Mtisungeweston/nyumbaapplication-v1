import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../models/message_model.dart';

class LocalStorageService {
  static const String messagesFileName = 'messages.json';
  static const String profilePhotoFileName = 'profile_photo.jpg';

  /// Get app documents directory
  static Future<Directory> _getAppDocumentDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  /// Save message to local storage
  static Future<void> saveMessage(MessageModel message) async {
    try {
      final dir = await _getAppDocumentDirectory();
      final messagesFile = File('${dir.path}/$messagesFileName');

      List<Map<String, dynamic>> messages = [];

      if (await messagesFile.exists()) {
        final content = await messagesFile.readAsString();
        final decoded = json.decode(content) as List;
        messages = List<Map<String, dynamic>>.from(
          decoded.map((x) => Map<String, dynamic>.from(x as Map)),
        );
      }

      messages.add(message.toJson());
      await messagesFile.writeAsString(json.encode(messages));
    } catch (e) {
      print('[v0] Error saving message: $e');
    }
  }

  /// Get all messages
  static Future<List<MessageModel>> getAllMessages() async {
    try {
      final dir = await _getAppDocumentDirectory();
      final messagesFile = File('${dir.path}/$messagesFileName');

      if (!await messagesFile.exists()) {
        return [];
      }

      final content = await messagesFile.readAsString();
      final decoded = json.decode(content) as List;
      return decoded
          .map((x) => MessageModel.fromJson(Map<String, dynamic>.from(x as Map)))
          .toList();
    } catch (e) {
      print('[v0] Error getting messages: $e');
      return [];
    }
  }

  /// Get messages for specific conversation
  static Future<List<MessageModel>> getConversationMessages(
    String userPhone,
  ) async {
    try {
      final allMessages = await getAllMessages();
      return allMessages
          .where((m) => m.fromPhone == userPhone || m.toPhone == userPhone)
          .toList();
    } catch (e) {
      print('[v0] Error getting conversation: $e');
      return [];
    }
  }

  /// Save profile photo
  static Future<void> saveProfilePhoto(File photoFile) async {
    try {
      final dir = await _getAppDocumentDirectory();
      final destination = File('${dir.path}/$profilePhotoFileName');
      await photoFile.copy(destination.path);
    } catch (e) {
      print('[v0] Error saving profile photo: $e');
    }
  }

  /// Get profile photo
  static Future<File?> getProfilePhoto() async {
    try {
      final dir = await _getAppDocumentDirectory();
      final photoFile = File('${dir.path}/$profilePhotoFileName');

      if (await photoFile.exists()) {
        return photoFile;
      }
      return null;
    } catch (e) {
      print('[v0] Error getting profile photo: $e');
      return null;
    }
  }

  /// Delete profile photo
  static Future<void> deleteProfilePhoto() async {
    try {
      final dir = await _getAppDocumentDirectory();
      final photoFile = File('${dir.path}/$profilePhotoFileName');

      if (await photoFile.exists()) {
        await photoFile.delete();
      }
    } catch (e) {
      print('[v0] Error deleting profile photo: $e');
    }
  }

  /// Clear all messages
  static Future<void> clearAllMessages() async {
    try {
      final dir = await _getAppDocumentDirectory();
      final messagesFile = File('${dir.path}/$messagesFileName');

      if (await messagesFile.exists()) {
        await messagesFile.delete();
      }
    } catch (e) {
      print('[v0] Error clearing messages: $e');
    }
  }
}
