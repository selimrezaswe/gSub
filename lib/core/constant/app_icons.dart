import 'package:subscription_manager/core/constant/app_assets.dart';

/// Subscription-relevant icons with unique IDs.
/// Use [AppIcon.allIcons] for the full list and [AppIcon.iconById] to look up by ID.
class AppIcon {
  final String id;
  final String assetPath;

  const AppIcon({required this.id, required this.assetPath});

  static final String _base = AppAssets.icons.basepath;

  /// All subscription-context icons. Each has a unique [id].
  static final List<AppIcon> allIcons = [
    AppIcon(id: 'icon_activity_chart', assetPath: '$_base/activity-chart.svg'),
    AppIcon(id: 'icon_bank_card', assetPath: '$_base/bank-card.svg'),
    AppIcon(id: 'icon_bank_card_security', assetPath: '$_base/bank-card-security.svg'),
    AppIcon(id: 'icon_bank_card_slash', assetPath: '$_base/bank-card-slash.svg'),
    AppIcon(id: 'icon_barcode_square', assetPath: '$_base/barcode-square.svg'),
    AppIcon(id: 'icon_basket_tick', assetPath: '$_base/basket-tick.svg'),
    AppIcon(id: 'icon_book_square', assetPath: '$_base/book-square.svg'),
    AppIcon(id: 'icon_briefcase', assetPath: '$_base/briefcase.svg'),
    AppIcon(id: 'icon_calendar_1', assetPath: '$_base/calendar-1.svg'),
    AppIcon(id: 'icon_calendar_circle', assetPath: '$_base/calendar-circle.svg'),
    AppIcon(id: 'icon_calendar_day', assetPath: '$_base/calendar-day.svg'),
    AppIcon(id: 'icon_clipboard_tick', assetPath: '$_base/clipboard-tick.svg'),
    AppIcon(id: 'icon_coins_1', assetPath: '$_base/coins-1.svg'),
    AppIcon(id: 'icon_coins_2', assetPath: '$_base/coins-2.svg'),
    AppIcon(id: 'icon_coins_3', assetPath: '$_base/coins-3.svg'),
    AppIcon(id: 'icon_coins_4', assetPath: '$_base/coins-4.svg'),
    AppIcon(id: 'icon_document_text_1', assetPath: '$_base/document-text-1.svg'),
    AppIcon(id: 'icon_document_text_2', assetPath: '$_base/document-text-2.svg'),
    AppIcon(id: 'icon_heart_tick', assetPath: '$_base/heart-tick.svg'),
    AppIcon(id: 'icon_home_trend_down', assetPath: '$_base/home-trend-down.svg'),
    AppIcon(id: 'icon_home_trend_up', assetPath: '$_base/home-trend-up.svg'),
    AppIcon(id: 'icon_inbox_1', assetPath: '$_base/inbox-1.svg'),
    AppIcon(id: 'icon_inbox_2', assetPath: '$_base/inbox-2.svg'),
    AppIcon(id: 'icon_inbox_3', assetPath: '$_base/inbox-3.svg'),
    AppIcon(id: 'icon_inbox_4', assetPath: '$_base/inbox-4.svg'),
    AppIcon(id: 'icon_money_add', assetPath: '$_base/money-add.svg'),
    AppIcon(id: 'icon_money_change', assetPath: '$_base/money-change.svg'),
    AppIcon(id: 'icon_money_in', assetPath: '$_base/money-in.svg'),
    AppIcon(id: 'icon_money_tick', assetPath: '$_base/money-tick.svg'),
    AppIcon(id: 'icon_money_time', assetPath: '$_base/money-time.svg'),
    AppIcon(id: 'icon_music', assetPath: '$_base/music.svg'),
    AppIcon(id: 'icon_music_list', assetPath: '$_base/music-list.svg'),
    AppIcon(id: 'icon_music_multi', assetPath: '$_base/music-multi.svg'),
    AppIcon(id: 'icon_safebox_1', assetPath: '$_base/safebox-1.svg'),
    AppIcon(id: 'icon_shop', assetPath: '$_base/shop.svg'),
    AppIcon(id: 'icon_shop_add', assetPath: '$_base/shop-add.svg'),
    AppIcon(id: 'icon_tag_1', assetPath: '$_base/tag-1.svg'),
    AppIcon(id: 'icon_tag_2', assetPath: '$_base/tag-2.svg'),
    AppIcon(id: 'icon_task_list_square', assetPath: '$_base/task-list-square.svg'),
    AppIcon(id: 'icon_tick_square', assetPath: '$_base/tick-square.svg'),
    AppIcon(id: 'icon_trend_up_square', assetPath: '$_base/trend-up-square.svg'),
    AppIcon(id: 'icon_video_1', assetPath: '$_base/video-1.svg'),
    AppIcon(id: 'icon_video_2', assetPath: '$_base/video-2.svg'),
    AppIcon(id: 'icon_wallet_2', assetPath: '$_base/wallet-2.svg'),
    AppIcon(id: 'icon_wallet_4', assetPath: '$_base/wallet-4.svg'),
    AppIcon(id: 'icon_wallet_open_add', assetPath: '$_base/wallet-open-add.svg'),
    AppIcon(id: 'icon_wallet_open_change', assetPath: '$_base/wallet-open-change.svg'),
    AppIcon(id: 'icon_wallet_search', assetPath: '$_base/wallet-search.svg'),
    AppIcon(id: 'icon_watch_activity', assetPath: '$_base/watch-activity.svg'),
    AppIcon(id: 'icon_chart_fail', assetPath: '$_base/chart-fail.svg'),
    AppIcon(id: 'icon_export_square', assetPath: '$_base/export-square.svg'),
    AppIcon(id: 'icon_import_1', assetPath: '$_base/import-1.svg'),
    AppIcon(id: 'icon_import_2', assetPath: '$_base/import-2.svg'),
    AppIcon(id: 'icon_secure', assetPath: '$_base/secure.svg'),
    AppIcon(id: 'icon_shield_lock', assetPath: '$_base/shield-lock.svg'),
    AppIcon(id: 'icon_shield_search', assetPath: '$_base/shield-search.svg'),
    AppIcon(id: 'icon_bulb', assetPath: '$_base/bulb.svg'),
    AppIcon(id: 'icon_note_favorite', assetPath: '$_base/note-favorite.svg'),
    AppIcon(id: 'icon_notif_circle', assetPath: '$_base/notif-circle.svg'),
    AppIcon(id: 'icon_3d_cube', assetPath: '$_base/3d-cube.svg'),
  ];

  static final Map<String, AppIcon> _byId = {
    for (final icon in allIcons) icon.id: icon,
  };

  /// Returns the icon with the given [id], or null if not found.
  static AppIcon? iconById(String id) => _byId[id];
}
