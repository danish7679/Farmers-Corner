class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'http://10.0.2.2:8000';

  static const String login = '/login';

  static const String register = '/register';

  static const String changePassword = '/change-password';

  static const String forgotPassword = '/forgot-password';

  static const String editProfile = '/edit-profile';

  static const String addMachine = '/add-machine';

  static const String getMachines = '/get-machines';

  static const String orderMachine = '/order-machine';

  static const String getOrders = '/get-orders';

  static const String getNotifications = '/get-notifications';

  static const String processNotification = '/process-notification';

  static const String scanCrop = '/scan-crop';
  static const String testImage =
      "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";
}
