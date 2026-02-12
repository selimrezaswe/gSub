/// Parameters for navigating to the App Detail screen.
///
/// Contains all the subscription information displayed on the detail page.
class AppDetailsParam {
  final String appName;
  final String appCategory;
  final String subscriptionDate;
  final String paymentCycle;
  final double subscriptionCost;
  final String remindMe;
  final String icon; // base64 encoded image
  final String description;
  final bool isSubscribed;
  final List<BillingEntry> billingHistory;

  const AppDetailsParam({
    required this.appName,
    required this.appCategory,
    required this.subscriptionDate,
    required this.paymentCycle,
    required this.subscriptionCost,
    required this.remindMe,
    required this.icon,
    required this.description,
    this.isSubscribed = true,
    this.billingHistory = const [],
  });
}

/// A single billing history entry.
class BillingEntry {
  final String month;
  final String date;
  final double amount;

  const BillingEntry({
    required this.month,
    required this.date,
    required this.amount,
  });
}
