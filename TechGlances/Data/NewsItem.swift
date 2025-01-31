import Foundation

struct NewsItem: Identifiable {
    let id = UUID()
    let title: String
    let link: String
    let image: URL?
    let publicationDate: Date
    let author: String
    var summary: String? // Populated after summarization
}
