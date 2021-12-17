class SearchResponseModel {
  String source,
      destination,
      dateOfJourney,
      busNumber,
      busName,
      agencyName,
      availableSeats,
      departureTime,
      arrivalTime,
      fare;

  SearchResponseModel(
      this.source,
      this.destination,
      this.dateOfJourney,
      this.busNumber,
      this.busName,
      this.agencyName,
      this.availableSeats,
      this.departureTime,
      this.arrivalTime,
      this.fare);
}

/* example json responce object 
{
    "Source": "New York",
    "Destination": "Los Angeles",
    "DateOfJourney": "31-01-2021",
    "AgencyName": "Agency1",
    "BusDetails": {
        "NumberPlate": "1234"
    },
    "AvailableSeatsItems": 10,
    "FareForOneSeat": 100.00,
    "DepartureTime": UNIXTimeObject
    "ArrivalTime": UNIXTimeObject
}

*/