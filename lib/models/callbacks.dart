
class Callbacks {
  final void Function(String? state)? onCallState;
  final void Function(String url)? onPageFinished;
  final Future<void> Function(String url, [String? filename])? onDownloadFile;

  const Callbacks({
    this.onCallState,
    this.onPageFinished,
    this.onDownloadFile
  });
}
