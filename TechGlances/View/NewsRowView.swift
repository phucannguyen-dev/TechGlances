import SwiftUI

struct NewsRowView: View {
    var news: NewsItem
    @ObservedObject var viewModel: NewsViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(news.title)
                .font(.headline)
                .onTapGesture {
                    viewModel.openLink(news.link) // ✅ Fix: Call openLink from ViewModel
                }

            if let summary = news.summary {
                Text(summary)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Button("Summarize") {
                // Implement summarization logic
                
            }
        }
    }
}
