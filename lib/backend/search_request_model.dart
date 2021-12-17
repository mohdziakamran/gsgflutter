class SearchRequestModel {
  String from;
  String to;
  DateTime datePicked;
  SearchRequestModel(this.from, this.to, this.datePicked);

  @override
  String toString() {
    return "From->$from \nTo->$to \nDate->${datePicked.toString()}";
  }
}
