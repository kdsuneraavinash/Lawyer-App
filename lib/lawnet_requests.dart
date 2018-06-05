import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

class Requests {
  http.Client client;
  List<Map<String, String>> parsedData;

  Requests() {
    client = new http.Client();
  }

  Future<List<Map<String, String>>> post(
    String searchString, [
    bool exactOnly = false,
    bool inTitle = true,
    bool inContent = false,
  ]) async {
    Map<String, String> jsonPost = {};
    String options = "";
    parsedData = [];

    options += "qtranslate_lang=0"
        "&customset%5B%5D=acf"
        "&customset%5B%5D=vc_grid_item"
        "&customset%5B%5D=portfolio"
        "&customset%5B%5D=blog_post"
        "&customset%5B%5D=post"
        "&customset%5B%5D=page";

    if (exactOnly) options += "&set_exactonly=checked";
    if (inTitle) options += "&set_intitle=None";
    if (inContent) options += "&set_incontent=None";

    jsonPost.addAll(
      {
        "action": "ajaxsearchpro_search",
        "aspp": searchString,
        "asid": "1",
        "asp_inst_id": "1_1",
        "options": options,
      },
    );
    var response = await client.post(
        "https://www.lawnet.gov.lk/wp-admin/admin-ajax.php",
        body: jsonPost);

    var document = parse(response.body);
    searchResultCrawler(document.body, new Map());
    return parsedData;
  }

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
        String content = path["content"];
        List<String> contentList = content
            .replaceAll(path["date"], "")
            .replaceAll(path["title"], "")
            .replaceAll(r"\n", "")
            .split(".pdf");
        String pdf;
        if (contentList.length == 2){
          pdf = contentList.first.trim();
        }
        content = contentList.last.trim();
        path["content"] = content;
        path["link"] = (pdf == null) ? null : path["link"];
        parsedData.add(new Map<String, String>.from(path));
        path.clear();
        break;
    }

    for (Element subElem in elem.children) {
      searchResultCrawler(subElem, path);
    }
  }
}