class Paginated<T> {
  const Paginated({required this.items, required this.hasMore});

  final List<T> items;
  final bool hasMore;
}
