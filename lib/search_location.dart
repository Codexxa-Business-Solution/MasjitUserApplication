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
    editController.addListener(onSearchInputChange);
  }

  @override
  void dispose() {
    editController.removeListener(onSearchInputChange);
    editController.dispose();

    super.dispose();
  }

  void onSearchInputChange() {
    if (editController.text.isEmpty) {
      debouncer?.cancel();
      widget.onSearchInput(editController.text);

      return;
    }

    if (debouncer?.isActive ?? false) {
      debouncer!.cancel();
    }

    debouncer = Timer(const Duration(milliseconds: 500), () {
      if(!isSearch){
        widget.onSearchInput(editController.text);
       
      }
   


    });
  }
  bool isSearch=false;
  onPassTextInputParameter(String text){
    isSearch=true;
    editController.text=text;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.screenHeight * .055,
      decoration: const BoxDecoration(
        color: CommonColor.SEARCH_COLOR,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child:
      Stack(
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
                prefixIcon: editController.text.isEmpty
                    ? Icon(
                  Icons.search_sharp,
                  color: CommonColor.SEARCH_TEXT_COLOR,
                  size: SizeConfig.screenHeight * .032,
                )
                    : null,

                suffixIcon: editController.text.isNotEmpty
                    ? IconButton(
                  onPressed: editController.clear,
                  icon: const Icon(
                    Icons.cancel,
                    color: CommonColor.BLACK,
                  ),
                )
                    : null,

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
            controller: editController,
            onChanged: (value) {
              isSearch=false;
              if(mounted) {
                setState(() {
                hasSearchEntry = value.isNotEmpty;
              });
              }
            },
          ),

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
                decoration: const BoxDecoration(
                  color: CommonColor.SEARCH_COLOR,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: parentWidth * 0.03),
                      child: Image(
                        image: const AssetImage("assets/images/search_image.png"),
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
                              icon: const Icon(
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

        ],
      ),
    );
  }
}
