import 'package:intl/intl.dart';

class SearchRequestModel {
  String from;
  String to;
  DateTime datePicked;
  SearchRequestModel(this.from, this.to, this.datePicked);

  Map<String, dynamic> toJson() => {
        'source': from,
        'destination': to,
        'date_of_journey': DateFormat('dd-MM-yyyy').format(datePicked)
        // '${datePicked.day}-${datePicked.month}-${datePicked.year}',
      };

  @override
  String toString() {
    return "From->$from \nTo->$to \nDate->${datePicked.toString()}";
  }
}
