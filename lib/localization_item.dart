class LocalizationItemClass {
  String languageCode;
  String nearBy;
  String findingPlace;
  String noResultsFound;
  String unnamedLocation;
  String tapToSelectLocation;


  LocalizationItemClass({
    this.languageCode = 'en_us',
    this.nearBy = 'Nearby Places',
    this.findingPlace = 'Finding place...',
    this.noResultsFound = 'There are no search results.',
    this.unnamedLocation = 'Unnamed location',
    this.tapToSelectLocation = 'Tap to select this location',
  });
}