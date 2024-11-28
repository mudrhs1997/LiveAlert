import Foundation


public struct Movie: Codable {
  public let title: String
  public let coverImage: String?

  public init(title: String, coverImage: String?) {
    self.title = title
    self.coverImage = coverImage
  }
}
