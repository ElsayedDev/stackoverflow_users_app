import 'package:url_launcher/url_launcher.dart';

abstract class AppLauncher {
  static Future<bool> openPost(int postId) async {
    final uri = Uri.parse('https://stackoverflow.com/questions/$postId');
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    return launched;
  }
}
