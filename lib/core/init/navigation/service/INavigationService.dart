abstract class INavigationService{
  Future<void> navigateToPage({required String path, required Object data});
  Future<void> navigateToPageClear({required String path, required Object data});

}