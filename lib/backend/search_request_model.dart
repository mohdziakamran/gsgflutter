class SearchRequestModel {
  String from;
  String to;
  DateTime datePicked;
  SearchRequestModel(this.from, this.to, this.datePicked);

  Map<String, dynamic> toJson() => {
        'Source': from,
        'Destination': to,
        'Date': '${datePicked.day}-${datePicked.month}-${datePicked.year}',
      };

  @override
  String toString() {
    return "From->$from \nTo->$to \nDate->${datePicked.toString()}";
  }
}
