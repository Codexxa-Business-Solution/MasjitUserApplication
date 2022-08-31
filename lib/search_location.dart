import 'dart:async';

import 'package:flutter/material.dart';
import 'package:masjiduserapp/size_config.dart';

import 'common.color.dart';

/// Custom Search input field, showing the search and clear icons.
class SearchLocationInput extends StatefulWidget {
  final ValueChanged<String> onSearchInput;

  const SearchLocationInput({Key? key, required this.onSearchInput}) : super(key: key);


  @override
  State<StatefulWidget> createState() => SearchLocationInputState();
}

class SearchLocationInputState extends State<SearchLocationInput> {
  TextEditingController editController = TextEditingController();

  Timer? debouncer;

  bool hasSearchEntry = false;

  SearchLocationInputState();

  @override
  void initState() {
    super.initState();
    this.editController.addListener(this.onSearchInputChange);
  }

  @override
  void dispose() {
    this.editController.removeListener(this.onSearchInputChange);
    this.editController.dispose();

    super.dispose();
  }

  void onSearchInputChange() {
    if (this.editController.text.isEmpty) {
      this.debouncer?.cancel();
      widget.onSearchInput(this.editController.text);

      return;
    }

    if (this.debouncer?.isActive ?? false) {
      this.debouncer!.cancel();
    }

    this.debouncer = Timer(Duration(milliseconds: 500), () {
      if(!isSearch){
        widget.onSearchInput(this.editController.text);
        print("texxxxttt 1111 ${editController.text}");
      }
      print("texxxxttt  22222  ${editController.text}");


    });
  }
  bool isSearch=false;
  onPassTextInputParameter(String text){
    isSearch=true;
    this.editController.text=text;
    // print("texxxxttt    $text");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.screenHeight * .055,
      decoration: BoxDecoration(
        color: CommonColor.SEARCH_COLOR,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            style: TextStyle(
              fontFamily: "Roboto_Regular",
              fontSize: SizeConfig.blockSizeHorizontal * 4.6,
              color: CommonColor.BLACK_COLOR,
            ),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: SizeConfig.screenWidth*.03,right: SizeConfig.screenWidth*.02),
                isDense: true,
                counterText: "",
                prefixIcon: editController.text.length == 0
                    ? Icon(
                  Icons.search_sharp,
                  color: CommonColor.SEARCH_TEXT_COLOR,
                  size: SizeConfig.screenHeight * .032,
                )
                    : null,
                /*suffixIcon: editController.text.length == 0
                      ?   Icon(
                          Icons.search_sharp,   color: CommonColor.SEARCH_TEXT_COLOR,size: SizeConfig.screenHeight * .023,
                        )
                      : null,*/
                suffixIcon: editController.text.isNotEmpty
                    ? IconButton(
                  onPressed: editController.clear,
                  icon: Icon(
                    Icons.cancel,
                    color: CommonColor.BLACK,
                  ),
                )
                    : null,
                /*  suffixStyle: FontConfig().primaryStyle(
                    TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.heading_black,
                        fontSize: uiManager.size(context, Dimention.size14)),
                  ),*/
                hintText: "search",
                hintStyle: TextStyle(
                  fontFamily: "Roboto_Medium",
                  fontSize: SizeConfig.blockSizeHorizontal * 4.6,
                  color: CommonColor.SEARCH_TEXT_COLOR,
                  // fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none),
            controller: this.editController,
            onChanged: (value) {
              isSearch=false;
              if(mounted) setState(() {
                this.hasSearchEntry = value.isNotEmpty;
              });
            },
          ),
          /*  if (this.hasSearchEntry)
              Padding(
                padding: EdgeInsets.only(
                    right: uiManager.width(context, Dimention.height16)),
                child: GestureDetector(
                  onTap: () {
                    editController.clear();
                    setState(() {
                      hasSearchEntry = false;
                    });
                  },
                  child: Container(
                    child: Text(
                      "clear".tr(),
                      style: FontConfig().primaryStyle(
                        TextStyle(
                            color: AppColors.provilac_orange,
                            fontSize: uiManager.size(context, Dimention.size14)),
                      ),
                    ),
                  ),
                ),
              ),*/
        ],
      ),
    );
  }

  /* Get Add Search Bar Layout */
  Widget getSearchBarLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * .02),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  left: parentWidth * .06, right: parentWidth * .05),
              child: Container(
                height: parentHeight * .055,
                decoration: BoxDecoration(
                  color: CommonColor.SEARCH_COLOR,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: parentWidth * 0.03),
                      child: Image(
                        image: new AssetImage("assets/images/search_image.png"),
                        fit: BoxFit.contain,
                        height: parentHeight * .028,
                        //  width: parentHeight * .023,
                        color: CommonColor.SEARCH_TEXT_COLOR,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: parentWidth * 0.02, right: parentWidth * .01),
                        child: TextFormField(
                          scrollPadding:
                          EdgeInsets.only(bottom: parentHeight * .005),
                          // controller: searchController,
                          // focusNode: _searchFocus,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: "",
                            hintText: "search",
                            hintStyle: TextStyle(
                              fontFamily: "Roboto_Medium",
                              fontSize: SizeConfig.blockSizeHorizontal * 4.8,
                              color: CommonColor.SEARCH_TEXT_COLOR,
                              // fontWeight: FontWeight.w500,
                            ),
                            suffixIcon: editController.text.isNotEmpty
                                ? IconButton(
                              onPressed: editController.clear,
                              icon: Icon(
                                Icons.cancel,
                                color: CommonColor.BLACK,
                              ),
                            )
                                : null,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontFamily: "Roboto_Regular",
                            fontSize: SizeConfig.blockSizeHorizontal * 4.6,
                            color: CommonColor.BLACK_COLOR,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     setState(() {});
          //   },
          //   onDoubleTap: () {},
          //   child: Padding(
          //     padding: EdgeInsets.only(right: parentWidth * .05),
          //     child: Text(
          //       StringEn.CANCEL,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
