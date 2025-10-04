mixin PaginatedFetchMixin {
  int _currentPage = 0;
  bool _isFetching = false;

  int get currentPage => _currentPage;
  bool get isFetching => _isFetching;

  bool beginFetch({bool resetPage = false}) {
    if (_isFetching) {
      return false;
    }
    _isFetching = true;
    if (resetPage) {
      _currentPage = 0;
    }
    return true;
  }

  void completeFetchSuccess(int page) {
    _currentPage = page;
    _isFetching = false;
  }

  void completeFetchFailure() {
    _isFetching = false;
  }
}
