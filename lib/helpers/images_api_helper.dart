import 'package:http/http.dart' as http;
import 'dart:typed_data';

class ImageAPIHelper {
  ImageAPIHelper._();

  static ImageAPIHelper imageAPIHelper = ImageAPIHelper._();

  Future<Uint8List?> getImage({required String search}) async {
    http.Response image = await http.get(
      Uri.parse("https://source.unsplash.com/random/?$search"),
    );

    if (image.statusCode == 200) {
      return image.bodyBytes;
    }
    return null;
  }
}
