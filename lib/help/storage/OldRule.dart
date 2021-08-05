import 'package:book_store/constant/AppConst.dart';
import 'package:book_store/constant/BookType.dart';
import 'package:book_store/db/BookSource.dart';
import 'package:book_store/utils/GSON.dart';

import 'BookSourceAny.dart';

class OldRule {

  static Future<BookSource?> jsonToBookSource(Map<String, dynamic> json) async {
    BookSource source = BookSource();
    BookSourceAny? sourceAny;
    try {
      sourceAny = BookSourceAny.fromJson(json);
    } catch (ignore) {}
    try {
      if (sourceAny == null) return null;
      if (sourceAny.ruleToc == null) {
        source.bookSourceUrl = json["bookSourceUrl"] ?? "";
        source.bookSourceName = json["bookSourceName"] ?? "";
        source.bookSourceGroup = json["bookSourceGroup"] ?? "";
        source.loginUrl = json["loginUrl"] ?? "";
        source.bookSourceComment = json["bookSourceComment"] ?? "";
        source.bookUrlPattern = json["ruleBookUrlPattern"] ?? "";
        source.customOrder = json["serialNumber"] ?? "";
        source.header = json["httpUserAgent"] ?? "";
        source.searchUrl = json["ruleSearchUrl"] ?? "";
        source.bookSourceType = (json["bookSourceType"] == "AUDIO") ? BookType.audioType : BookType.defaultType;
        source.enabled = json["enabled"] ?? true;
        if (source.exploreUrl?.isEmpty == true) {
          source.enabledExplore = false;
        }

      } else {
        source.bookSourceUrl = sourceAny.bookSourceUrl;
        source.bookSourceName = sourceAny.bookSourceName;
        source.bookSourceGroup = sourceAny.bookSourceGroup;
        source.bookSourceType = sourceAny.bookSourceType;
        source.bookUrlPattern = sourceAny.bookUrlPattern;
        source.customOrder = sourceAny.customOrder;
        source.enabled = sourceAny.enabled;
        source.enabledExplore = sourceAny.enabledExplore;
        source.header = sourceAny.header;
        source.loginUrl = sourceAny.loginUrl;
        source.bookSourceComment = sourceAny.bookSourceComment;
        source.lastUpdateTime = sourceAny.lastUpdateTime;
        source.weight = sourceAny.weight;
        source.exploreUrl = sourceAny.exploreUrl;
      }
    } catch (ignore) {}
    return source;
  }

  String? uaToHeader(String? ua) {
    if (ua == null || ua.isEmpty == true) return null;
    Map<String, String> map = {AppConst.UA_NAME: ua};
    return GSON.toJson(map);
  }
}
