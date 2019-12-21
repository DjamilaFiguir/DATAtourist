class Tourism {
  Data data;
  Tourism({this.data});
  factory Tourism.fromJson(Map<String, dynamic> parsedJson) {
    var mydata = Data.fromJson(parsedJson['data']);
    return Tourism(data: mydata);
  }
}

//data
class Data {
  Poi poi;

  Data({
    this.poi,
  });
  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    var mypoi = Poi.fromJson(parsedJson['poi']);
    return Data(poi: mypoi);
  }
}

//poi
class Poi {
  List<Results> results;
  int total;

  Poi({this.results, this.total});

  factory Poi.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    List<Results> resultsList = list.map((i) => Results.fromJson(i)).toList();

    var totalFromJson = parsedJson['total'];
    int totalList = totalFromJson;

    return Poi(results: resultsList, total: totalList);
  }
}

//results
class Results {
  List<String> rdfslabel;
  List<HasDescription> hasDescription;
  List<HasArchitecturalStyle> hasArchiStyle;
  List<ProvidesCuisineOfType> providesCuisineOfType;
  List<HasTheme> hasTheme;
  List<Hascontact>hascontact;
  List<IsLocatedAt> isLocatedAt;
  List<HasReview> hasReview;
  List<Offers> offers;
  List<IsEquippedWith> isEquippedWith;
  Results(
      {this.rdfslabel,
      this.hasDescription,
      this.hasArchiStyle,
      this.providesCuisineOfType,
      this.hasTheme,
      this.hascontact,
      this.isLocatedAt,
      this.hasReview,
      this.offers,
      this.isEquippedWith});

  factory Results.fromJson(Map<String, dynamic> parsedJson) {
    var rdfslabelFromJson = parsedJson['rdfs_label'];
    List<String> rdfslabelList = rdfslabelFromJson.cast<String>();

    var description = parsedJson['hasDescription'] as List;
    List<HasDescription> descriptionList;
    if (parsedJson['hasDescription'] != null) {
      descriptionList =
          description.map((i) => HasDescription.fromJson(i)).toList();
    }

    var archiStyle = parsedJson['hasArchitecturalStyle'] as List;
    List<HasArchitecturalStyle> archiStyleList;
    if (parsedJson['hasArchitecturalStyle'] != null) {
      archiStyleList =
          archiStyle.map((i) => HasArchitecturalStyle.fromJson(i)).toList();
    }

    var pcuisineOfType = parsedJson['providesCuisineOfType'] as List;
    List<ProvidesCuisineOfType> pcuisineOfTypeList;
    if (parsedJson['providesCuisineOfType'] != null) {
      pcuisineOfTypeList =
          pcuisineOfType.map((i) => ProvidesCuisineOfType.fromJson(i)).toList();
    }

    var theme = parsedJson['hasTheme'] as List;
    List<HasTheme> themeList;
    if (parsedJson['hasTheme'] != null) {
      themeList =
          theme.map((i) => HasTheme.fromJson(i)).toList();
    }

    var contact = parsedJson['hasContact'] as List;
    List<Hascontact> contactList;
    if (parsedJson['hasContact'] != null) {
      contactList = contact.map((i) => Hascontact.fromJson(i)).toList();
    }

    var isLocatedAt = parsedJson['isLocatedAt'] as List;
    List<IsLocatedAt> isLocatedAtList = [];
    isLocatedAtList = isLocatedAt.map((i) => IsLocatedAt.fromJson(i)).toList();

    var hasReview = parsedJson['hasReview'] as List;
    List<HasReview> hasReviewList = [];
    hasReviewList = hasReview.map((i) => HasReview.fromJson(i)).toList();

    var offers = parsedJson['offers'] as List;
    List<Offers> offersList = [];
    offersList = offers.map((i) => Offers.fromJson(i)).toList();

    var isEquippedWith = parsedJson['isEquippedWith'] as List;
    List<IsEquippedWith> isEquippedWithList =
        isEquippedWith.map((i) => IsEquippedWith.fromJson(i)).toList();

    return new Results(
        rdfslabel: rdfslabelList,
        hasDescription: descriptionList,
        hasArchiStyle: archiStyleList,
        providesCuisineOfType: pcuisineOfTypeList,
        hasTheme: themeList,
        hascontact: contactList,
        isLocatedAt: isLocatedAtList,
        hasReview: hasReviewList,
        offers: offersList,
        isEquippedWith: isEquippedWithList);
  }
}

//description
class HasDescription {
  List<String> shortDescription;

  HasDescription({
    this.shortDescription,
  });

  factory HasDescription.fromJson(Map<String, dynamic> parsedJson) {
    var shortDescriptionFromJson;
    List<String> shortDescriptionlList;
    if (parsedJson != null) {
      shortDescriptionFromJson = parsedJson['shortDescription'];
      shortDescriptionlList = shortDescriptionFromJson.cast<String>();
    }
    return new HasDescription(
      shortDescription: shortDescriptionlList,
    );
  }
}

//archi style
class HasArchitecturalStyle {
  List<String> rdfslabelArchiStyle;

  HasArchitecturalStyle({
    this.rdfslabelArchiStyle,
  });

  factory HasArchitecturalStyle.fromJson(Map<String, dynamic> parsedJson) {
    var rdfslabelArchiStyleFromJson;
    List<String> rdfslabelArchiStyleList;
    if (parsedJson['rdfs_label'] != null) {
      rdfslabelArchiStyleFromJson = parsedJson['rdfs_label'];
      rdfslabelArchiStyleList = rdfslabelArchiStyleFromJson.cast<String>();
    }
    return new HasArchitecturalStyle(
      rdfslabelArchiStyle: rdfslabelArchiStyleList,
    );
  }

}
//cuisine type
class ProvidesCuisineOfType {
  List<String> rdfslabelCuisineOfType;

  ProvidesCuisineOfType({
    this.rdfslabelCuisineOfType,
  });

  factory ProvidesCuisineOfType.fromJson(Map<String, dynamic> parsedJson) {
    var rdfslabelCuisineOfTypeFromJson;
    List<String> rdfslabelCuisineOfTypeList;
    if (parsedJson['rdfs_label'] != null) {
      rdfslabelCuisineOfTypeFromJson = parsedJson['rdfs_label'];
      rdfslabelCuisineOfTypeList = rdfslabelCuisineOfTypeFromJson.cast<String>();
    }
    return new ProvidesCuisineOfType(
      rdfslabelCuisineOfType: rdfslabelCuisineOfTypeList,
    );
  }

}


//hastheme
class HasTheme {
  List<String> rdfslabeltheme;

  HasTheme({
    this.rdfslabeltheme,
  });

  factory HasTheme.fromJson(Map<String, dynamic> parsedJson) {
    var rdfslabelthemeFromJson;
    List<String> rdfslabelthemeList;
    if (parsedJson != null) {
      rdfslabelthemeFromJson = parsedJson['rdfs_label'];
      rdfslabelthemeList = rdfslabelthemeFromJson.cast<String>();
    }
    return new HasTheme(
      rdfslabeltheme: rdfslabelthemeList,
    );
  }
}
 

//hascontact
class Hascontact {
  List<String> foafhomepage;
  List<String> schematelephone;
  List<String> schemaemail;

  Hascontact({
    this.foafhomepage,
    this.schematelephone,
    this.schemaemail,
  });

  factory Hascontact.fromJson(Map<String, dynamic> parsedJson) {

    var foafhomepageFromJson;
    List<String> foafhomepageList;
    if (parsedJson['foaf_homepage'] != null) {
      foafhomepageFromJson = parsedJson['foaf_homepage'];
      foafhomepageList = foafhomepageFromJson.cast<String>();
    }

    var schematelephoneFromJson;
    List<String> schematelephoneList;
    if (parsedJson['schema_telephone'] != null) {
      schematelephoneFromJson = parsedJson['schema_telephone'];
      schematelephoneList = schematelephoneFromJson.cast<String>();
    }

    var schemaemailFromJson;
    List<String> schemaemailList;
    if (parsedJson['schema_email'] != null) {
      schemaemailFromJson = parsedJson['schema_email'];
      schemaemailList = schemaemailFromJson.cast<String>();
    }


    return new Hascontact(
      foafhomepage: foafhomepageList,
      schematelephone:schematelephoneList ,
      schemaemail: schemaemailList,

    );
  }
}

//isLocatedAt
class IsLocatedAt {
  List<SchemaAddress> schemaAddress;
  List<Schemageo> schemageo;

  IsLocatedAt({this.schemaAddress, this.schemageo});

  factory IsLocatedAt.fromJson(Map<String, dynamic> parsedJson) {

    var isLocatedAt = parsedJson['schema_address'] as List;
    List<SchemaAddress> schemaAddressList =
        isLocatedAt.map((i) => SchemaAddress.fromJson(i)).toList();

    var isLocatedAt2 = parsedJson['schema_geo'] as List;
    List<Schemageo> schemageoList =
        isLocatedAt2.map((i) => Schemageo.fromJson(i)).toList();

    return new IsLocatedAt(
        schemaAddress: schemaAddressList, schemageo: schemageoList);
  }
}

//Schema_address
class SchemaAddress {
  List<String> schemaAddressLocality;
  SchemaAddress({
    this.schemaAddressLocality,
  });

  factory SchemaAddress.fromJson(Map<String, dynamic> parsedJson) {
    var schemaAddressLocalityFromJson = parsedJson['schema_addressLocality'];
    List<String> schemaAddressLocalitylList =
        schemaAddressLocalityFromJson.cast<String>();

    return new SchemaAddress(
      schemaAddressLocality: schemaAddressLocalitylList,
    );
  }
}

class Schemageo {
  List<double> schemalatitude;
  List<double> schemalongitude;
  Schemageo({
    this.schemalatitude,
    this.schemalongitude,
  });

  factory Schemageo.fromJson(Map<String, dynamic> parsedJson) {
    var schemalatitudeFromJson = parsedJson['schema_latitude'];
    List<double> schemalatitudeList = schemalatitudeFromJson.cast<double>();

    var schemalongitudeFromJson = parsedJson['schema_longitude'];
    List<double> schemalongitudeList = schemalongitudeFromJson.cast<double>();

    return new Schemageo(
      schemalatitude: schemalatitudeList,
      schemalongitude: schemalongitudeList,
    );
  }
}

//HasReview
class HasReview {
  List<HasReviewValue> hasReviewValue;

  HasReview({
    this.hasReviewValue,
  });

  factory HasReview.fromJson(Map<String, dynamic> parsedJson) {
    var hasReviewValue = parsedJson['hasReviewValue'] as List;
    List<HasReviewValue> hasReviewValueList =
        hasReviewValue.map((i) => HasReviewValue.fromJson(i)).toList();

    return new HasReview(hasReviewValue: hasReviewValueList);
  }
}

//HasReviewValue
class HasReviewValue {
  List<String> rdfslabelreview;
  HasReviewValue({
    this.rdfslabelreview,
  });

  factory HasReviewValue.fromJson(Map<String, dynamic> parsedJson) {
    var rdfslabelreviewFromJson = parsedJson['rdfs_label'];
    List<String> rdfslabelreviewList = rdfslabelreviewFromJson.cast<String>();

    return new HasReviewValue(
      rdfslabelreview: rdfslabelreviewList,
    );
  }
}

//offers
class Offers {
  List<SchemaacceptedPaymentMethod> schemaacceptedPaymentMethod;

  Offers({
    this.schemaacceptedPaymentMethod,
  });

  factory Offers.fromJson(Map<String, dynamic> parsedJson) {
    var schemaacceptedPaymentMethod =
        parsedJson['schema_acceptedPaymentMethod'] as List;
    List<SchemaacceptedPaymentMethod> schemaacceptedPaymentMethodList =
        schemaacceptedPaymentMethod
            .map((i) => SchemaacceptedPaymentMethod.fromJson(i))
            .toList();

    return new Offers(
        schemaacceptedPaymentMethod: schemaacceptedPaymentMethodList);
  }
}

//SchemaacceptedPaymentMethod
class SchemaacceptedPaymentMethod {
  List<String> rdfslabelPayment;
  SchemaacceptedPaymentMethod({
    this.rdfslabelPayment,
  });

  factory SchemaacceptedPaymentMethod.fromJson(
      Map<String, dynamic> parsedJson) {
    var rdfslabelPaymentFromJson = parsedJson['rdfs_label'];
    List<String> rdfslabelPaymentList = rdfslabelPaymentFromJson.cast<String>();

    return new SchemaacceptedPaymentMethod(
      rdfslabelPayment: rdfslabelPaymentList,
    );
  }
}

//is equipped
class IsEquippedWith {
  List<String> rdfslabelEquipped;
  IsEquippedWith({
    this.rdfslabelEquipped,
  });

  factory IsEquippedWith.fromJson(Map<String, dynamic> parsedJson) {
    var rdfslabelEquippedFromJson = parsedJson['rdfs_label'];
    List<String> rdfslabelEquippedList =
        rdfslabelEquippedFromJson.cast<String>();

    return new IsEquippedWith(
      rdfslabelEquipped: rdfslabelEquippedList,
    );
  }
}

class Mydata {
  String rdfslabel;
  String shortDescription;
  List<String> cuisineType;
  String archiStyle;
  List<String> rdfslabeltheme;
  String foafhomepage;
  String schematelephone;
  String schemaemail;
  String schemaAddressLocality;
  String rdfslabelreview;
  List<String> rdfslabelPayment;
  List<String> rdfslabelEquipped;
  double schemalatitude;
  double schemalongitude;
  int total;
  Mydata(
      this.total,
      this.rdfslabel,
      this.shortDescription,
      this.cuisineType,
      this.archiStyle,
      this.rdfslabeltheme,
      this.foafhomepage,
      this.schematelephone,
      this.schemaemail,
      this.schemaAddressLocality,
      this.rdfslabelreview,
      this.rdfslabelPayment,
      this.rdfslabelEquipped,
      this.schemalatitude,
      this.schemalongitude);
}
