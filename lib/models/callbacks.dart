class Callbacks {
  final void Function(int progress)? onPageLoadProgress;
  final void Function(Uri? url)? onPageLoadFinished;

  final void Function(String state)? onCallState;
  final void Function(String state)? onPiPState;

  final Future<void> Function(String url, [String? filename])? onDownloadFile;

  const Callbacks({
    this.onPageLoadProgress,
    this.onPageLoadFinished,
    this.onCallState,
    this.onPiPState,
    this.onDownloadFile,
  });
}
