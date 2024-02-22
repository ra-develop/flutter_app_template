import 'dart:io';

// Resolve fails CERTIFICATE_VERIFY_FAILED for HTTPS site with no certificate
// for Global
class CertificateVerifyResolve extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
