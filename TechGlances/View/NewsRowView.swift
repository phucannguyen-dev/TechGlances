import SwiftUI

struct NewsRowView: View {
    var news: NewsItem
    @ObservedObject var viewModel: NewsViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .lastTextBaseline) {
                AsyncImage(url: news.image) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    @unknown default:
                        EmptyView()
                    }
                }
                VStack(alignment: .leading) {
                    Text(news.title)
                        .font(.headline)
                        .onTapGesture {
                            viewModel.openLink(news.link) // ✅ Fix: Call openLink from ViewModel
                        }
                    Text(news.publicationDate, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                if let summary = news.summary {
                    Text(summary)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Button() {
                    
                } label: {
                    Image(systemName: "text.append")
                }
            }
        }
    }
}
