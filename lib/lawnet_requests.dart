import 'dart:async';

import 'package:http/http.dart' as http;

class Requests {
  http.Client client;

  Requests() {
    client = new http.Client();
  }

  Future<String> post(
    String searchString, [
    bool exactOnly = false,
    bool inTitle = true,
    bool inContent = false,
  ]) async {
    Map<String, String> jsonPost = {};
    String options = "";

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
    return response.body;
  }
}
