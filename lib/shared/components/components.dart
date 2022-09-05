import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

Widget buildNewsItem(article, context) {
  return InkWell(
    onTap: (){
      navigatTo(context, WebViewScreen(article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            width: 140.0,
            height: 140.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: CachedNetworkImage(
              imageUrl: '${article['urlToImage']}',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                value: downloadProgress.progress,
              ),
              errorWidget: (context, url, error) =>
                  Icon(Icons.downloading, color: Colors.grey),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Container(
              height: 140.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildSeperatedContainerList() {
  return Padding(
    padding: const EdgeInsetsDirectional.only(start: 10.0),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey,
    ),
  );
}

Widget buildConditionalNews(List<dynamic> list) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildNewsItem(list[index], context),
        separatorBuilder: (context, index) => buildSeperatedContainerList(),
        itemCount: list.length),
    fallback: (context) => Center(child: CircularProgressIndicator()),
  );
}

Widget defultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  required FormFieldValidator functionValidator,
  ValueChanged<String>? functionOnChange,
  bool isPassword = false,
  IconData? sufix,
  VoidCallback? sufixOnPressed,
}) {
  return TextFormField(
    obscureText: isPassword,
    controller: controller,
    keyboardType: type,
    onChanged: functionOnChange,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        prefix,
      ),
      suffixIcon: sufix != null
          ? IconButton(onPressed: sufixOnPressed, icon: Icon(sufix))
          : null,
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
      labelStyle: TextStyle(
        color: Colors.black,
      ),
    ),
    validator: functionValidator,
  );
}

void navigatTo(context,widget){
  Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=> widget
      )
  );
}
