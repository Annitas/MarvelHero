//
//  HeroModel.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 02.11.2022.
//

//struct Hero: Decodable {
//    var name: String?
//    var description: String?
//    var path: String?
//    var message: String?
//    var code: String?
//
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//        case description = "description"
//        case path = "path"
//        case code = "code"
//        case message = "message"
//    }
//}

public struct MarvelData: Decodable {
  
  /// The requested offset (number of skipped results) of the call.
  public let offset: Int?
  
  /// The requested result limit.
  public let limit: Int?
  
  /// The total number of resources available given the current filter set.
  public let total: Int?
  
  /// The total number of results returned by this call.
  public let count: Int?
  
  /// The list of characters returned by the call.
  public let results: [Character]?
}

public struct Character: Decodable {
  
  /// The unique ID of the character resource.
  public let id: Int?
  
  /// The name of the character.
  public let name: String?
  
  ///  A short bio or description of the character.
  public let description: String?
  
  /// The date the resource was most recently modified.
  // let modified: Date?
  // TODO: Decode Dates
  
  /// The canonical URL identifier for this resource.
  // let resourceURI: URL?
  // TODO: Decode URLs
  
  /// A set of public web site URLs for the resource.
  // let urls: [Url]
  // TODO: Decode URLs
  
  /// The representative image for this character.
  // let thumbnail: Image
  // TODO: Add an Thumbnail type
  
  /// A resource list containing comics which feature this character.
  // let comics: ComicList?
  // TODO: Add an ComicList type
  
  /// A resource list of stories in which this character appears.
  // let stories: StoryList?
  // TODO: Add an StoryList type
  
  /// A resource list of events in which this character appears.
  // let events: EventList?
  // TODO: Add an EventList type
  
  /// A resource list of series in which this character appears.
  // let series: SeriesList?
  // TODO: Add an SeriesList type
}

public struct CharacterDataWrapper: Decodable {

  /// The HTTP status code of the returned result.
  public let code: Int? //Int
  
  /// A string description of the call status.
  public let status: String?
  
  ///The copyright notice for the returned result.
  public let copyright: String?
  
  /// The attribution notice for this result. Please display either this notice or the contents of the attributionHTML field on all screens which contain data from the Marvel Comics API.
  public let attributionText: String?
  
  /// An HTML representation of the attribution notice for this result. Please display either this notice or the contents of the attributionText field on all screens which contain data from the Marvel Comics API.
  public let attributionHTML: String?
  
  /// The results returned by the call.
  public let data: MarvelData?
  
  /// A digest value of the content returned by the call.
  public let etag: String?
}
