import Foundation


public struct Alarm: Codable {
  public let id: String
  public let content: String
  public let trigger: String?

  public init(id: String, content: String, trigger: String?) {
    self.id = id
    self.content = content
    self.trigger = trigger
  }
}
