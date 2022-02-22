import SwiftUI

struct BookmarkModel: Codable, Identifiable, Hashable {
    var id = UUID()
    var title: String
    var linkURL: String
}
