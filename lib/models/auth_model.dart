class AuthModel {
  final String? phoneNumber;
  final bool isOtpSent;
  final bool isVerified;
  final String? errorMessage;

  AuthModel({
    this.phoneNumber,
    this.isOtpSent = false,
    this.isVerified = false,
    this.errorMessage,
  });

  AuthModel copyWith({
    String? phoneNumber,
    bool? isOtpSent,
    bool? isVerified,
    String? errorMessage,
  }) {
    return AuthModel(
      phoneNumber: phoneNumber != null ? phoneNumber : this.phoneNumber,
      isOtpSent: isOtpSent != null ? isOtpSent : this.isOtpSent,
      isVerified: isVerified != null ? isVerified : this.isVerified,
      errorMessage: errorMessage != null ? errorMessage : this.errorMessage,
    );
  }
}
