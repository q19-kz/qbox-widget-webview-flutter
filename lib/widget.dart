
library qbox_widget_webview;

export 'models/init.dart';
import 'base.dart';
import 'debug.dart';


class WebWidget extends BaseWebWidget with DebugMixin {
  WebWidget(super.settings, [super.callbacks]);
}
