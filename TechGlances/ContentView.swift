import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NewsViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.newsItems) { news in
                NewsRowView(news: news, viewModel: viewModel)
            }
            .navigationTitle("News")
            .onAppear {
                viewModel.fetchRSSFeeds()
            }
        }
    }
}

