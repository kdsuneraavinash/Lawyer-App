import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

class Requests {
  http.Client client;
  List<Map<String, String>> parsedData;

  Requests() {
    client = http.Client();
  }

  /// * Build Search Options
  String _searchOptionsBuilder([
    bool exactOnly = false,
    bool inTitle = true,
    bool inContent = false,
  ]) {
    String options = "";

    options += "qtranslate_lang=0" // ? Unknown
        "&customset%5B%5D=acf" // ? Unknown
        "&customset%5B%5D=vc_grid_item" // ? Unknown
        "&customset%5B%5D=portfolio" // ? Unknown
        "&customset%5B%5D=blog_post" // ? Unknown
        "&customset%5B%5D=post" // ? Unknown
        "&customset%5B%5D=page"; // ? Unknown

    if (exactOnly) options += "&set_exactonly=checked"; // Search Exact Text
    if (inTitle) options += "&set_intitle=None"; // Search in Titles
    if (inContent) options += "&set_incontent=None"; // Search in Content(Slow)

    return options;
  }

  /// * Main POST Function
  Future<List<Map<String, String>>> post(
    String searchString, [
    bool exactOnly = false,
    bool inTitle = true,
    bool inContent = false,
  ]) async {
    Map<String, String> jsonPost = {};
    String options = _searchOptionsBuilder(exactOnly, inTitle, inContent);
    parsedData = [];

    // Build JSON POST
    jsonPost.addAll(
      {
        "action": "ajaxsearchpro_search", // ? Unknown
        "aspp": searchString, // Search Text
        "asid": "1", // ? Unknown
        "asp_inst_id": "1_1", // ? Unknown
        "options": options, // Search Options
      },
    );

    // Send POST
    var response = await client.post(
      "https://www.lawnet.gov.lk/wp-admin/admin-ajax.php",
      body: jsonPost,
    );

    // Parse Document
    Document document = parse(response.body);
    // Format as needed and Extract Data
    try {
      searchResultCrawler(document.body, Map());
    } catch (e) {
      // ! Error Occured
      return [];
    }
    return parsedData;
  }

  /// * Extract Search Results
  void searchResultCrawler(Element elem, Map<String, String> path) {
    switch (elem.className) {
      case "asp_res_url":
        path["link"] = elem.attributes["href"];
        path["title"] = elem.text.trim();
        break;
      case "asp_date":
        path["date"] = elem.text.trim();
        break;
      case "asp_content":
        path["content"] = elem.text.trim();
        break;
      case "asp_spacer":
        // End of one item
        String content = path["content"];
        List<String> contentList = content
            .replaceAll(path["date"], "")
            .replaceAll(path["title"], "")
            .replaceAll(r"\n", " ")
            .split(".pdf");
        String pdf = contentList.first.trim();
        if (contentList.length != 2) {
          // ! Error Occured
          pdf = null;
        }
        content = contentList.last.trim();
        path["content"] = content;
        path["link"] = (pdf == null) ? null : path["link"];
        parsedData.add(Map<String, String>.from(path));
        path.clear();
    }

    // Recursive approach
    for (Element subElem in elem.children) {
      searchResultCrawler(subElem, path);
    }
  }
}
