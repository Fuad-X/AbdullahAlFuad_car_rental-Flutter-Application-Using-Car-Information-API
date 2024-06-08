class ReservationDetailsClass {
  final String id;
  final String hours;
  final String days;
  final String weeks;
  final String pickupDate;
  final String returnDate;
  final String discount;

  ReservationDetailsClass({
    required this.id,
    required this.hours,
    required this.days,
    required this.weeks,
    required this.pickupDate,
    required this.returnDate,
    this.discount = "",
  });
}