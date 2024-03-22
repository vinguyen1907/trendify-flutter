import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class ChatUtil {
  Future<File> compressImage(File imageFile) async {
    final tempDir = await getTemporaryDirectory();
    final tempFilePath =
        '${tempDir.path}/compressed_image${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';

    await FlutterImageCompress.compressAndGetFile(
      imageFile.path,
      tempFilePath,
      minHeight: 1920,
      minWidth: 1080,
      quality: 50,
      rotate: 0,
    );

    return File(tempFilePath);
  }
}
