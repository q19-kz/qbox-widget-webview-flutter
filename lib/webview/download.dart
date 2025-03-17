import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

import 'base.dart';

mixin DownloadMixin on BaseController {
  Future<NavigationActionPolicy> onUrlOverride(controller, action) async {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      final shouldPerformDownload = action.shouldPerformDownload ?? false;
      final url = action.request.url;
      if (shouldPerformDownload && url != null) {
        final handler = callbacks?.onDownloadFile ?? handleDownload;
        await handler(url.toString());
        return NavigationActionPolicy.DOWNLOAD;
      }
    }
    return NavigationActionPolicy.ALLOW;
  }

  Future<void> onDownloadStart(controller, downloadStart) async {
    final url = downloadStart.url.toString();
    final filename = downloadStart.suggestedFilename;
    final handler = callbacks?.onDownloadFile ?? handleDownload;
    await handler(url, filename);
  }

  Future<void> handleDownload(String url, [String? filename]) async {
    await launchUrl(Uri.parse(url));
  }
}
