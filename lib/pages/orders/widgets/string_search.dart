class StringSearch {
  StringSearch(this.input, this.searchTerm);
  final List<String> input;
  final String searchTerm;
  List<String> relevantResults() {
    // the search term should be more than 2
    if (searchTerm.length < 2) {
      return [];
    }

    return input
        .where((item) => item.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
  }
}
