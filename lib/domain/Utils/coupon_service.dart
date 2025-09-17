// Enum to define the type of discount
enum DiscountType { percentage, flat }

// Data model for our coupon
class Coupon {
  final String code;
  final DiscountType type;
  final double value;

  Coupon({required this.code, required this.type, required this.value});
}

// This class simulates fetching coupon data from an API
class CouponService {
  // Our dummy database of valid coupons
  final Map<String, Coupon> _coupons = {
    'FLAT10': Coupon(code: 'FLAT10', type: DiscountType.flat, value: 10.0),
    'SAVE15': Coupon(code: 'SAVE15', type: DiscountType.percentage, value: 15.0),
    'BIGSALE': Coupon(code: 'BIGSALE', type: DiscountType.percentage, value: 25.0),
  };

  // Simulates an API call to validate a coupon code
  Future<Coupon?> validateCoupon(String code) async {
    // Add a small delay to mimic network latency
    await Future.delayed(const Duration(milliseconds: 500));
    return _coupons[code.toUpperCase()];
  }
}