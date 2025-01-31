import SwiftUI
import FeedKit

class NewsViewModel: ObservableObject {
    @Published var newsItems: [NewsItem] = []
    
    // 🔹 List of RSS feed URLs
    private let rssFeeds: [String] = [
        "https://www.apple.com/newsroom/rss-feed.rss",
        "https://9to5mac.com/feed/",
        "https://www.theverge.com/rss/index.xml",
        "https://www.cnet.com/rss/news/"
    ]

    /// Fetch news from all RSS feeds
    func fetchRSSFeeds() {
        let group = DispatchGroup() // Manage multiple async tasks
        var allNews: [NewsItem] = []

        for feedURL in rssFeeds {
            guard let url = URL(string: feedURL) else { continue }
            let parser = FeedParser(URL: url)

            group.enter() // Start tracking this task
            parser.parseAsync(queue: DispatchQueue.global(qos: .background)) { [weak self] result in
                switch result {
                case .success(let feed):
                    let newsFromFeed = self?.parseFeed(feed: feed) ?? []
                    DispatchQueue.main.async {
                        allNews.append(contentsOf: newsFromFeed)
                    }
                case .failure(let error):
                    print("❌ Error fetching RSS feed (\(feedURL)): \(error.localizedDescription)")
                }
                group.leave() // Mark this task as complete
            }
        }

        // 🔹 Once all feeds are parsed, update `newsItems`
        group.notify(queue: DispatchQueue.main) {
            self.newsItems = allNews.sorted { $0.publicationDate > $1.publicationDate }
        }
    }

    /// Parses RSS feed and converts it into `NewsItem` models
    private func parseFeed(feed: Feed) -> [NewsItem] {
        guard let items = feed.rssFeed?.items else { return [] }

        return items.compactMap { item in
            guard let title = item.title,
                  let link = item.link,
                  let date = item.pubDate else {
                return nil
            }

            return NewsItem(
                title: title,
                link: link,
                image: item.enclosure?.attributes?.url.flatMap(URL.init),
                publicationDate: date,
                author: item.author ?? "Unknown"
            )
        }
    }

    /// Opens a news link in the browser
    func openLink(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL: \(urlString)")
            return
        }
        UIApplication.shared.open(url)
    }
}
