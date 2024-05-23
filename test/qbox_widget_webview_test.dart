
import 'package:qbox_widget_webview/widget.dart' as qbox;

void main() {
  final qboxWidget = qbox.WebWidget(
      const qbox.Settings(
          url: 'https://inqbox.q19.kz/wc/',
          language: qbox.Language.ru,
          call: qbox.Call(
              domain: 'dev.test.kz',
              topic: 'sos_test_free'
          )
      )
  );

  final webview = qboxWidget.build();
}
