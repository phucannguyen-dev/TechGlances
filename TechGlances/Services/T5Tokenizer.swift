import Foundation

class T5Tokenizer {
    private var vocab: [String: Int] = [:]
    private var invVocab: [Int: String] = [:]

    init() {
        loadVocabulary()
    }

    private func loadVocabulary() {
        if let path = Bundle.main.path(forResource: "t5_vocab", ofType: "txt") {
            do {
                let content = try String(contentsOfFile: path, encoding: .utf8)
                for line in content.split(separator: "\n") {
                    let parts = line.split(separator: "\t")
                    if parts.count == 2, let index = Int(parts[1]) {
                        let token = String(parts[0])
                        vocab[token] = index
                        invVocab[index] = token
                    }
                }
            } catch {
                print("Error loading vocab: \(error)")
            }
        }
    }

    func encode(text: String) -> [Int] {
        let tokens = text.split(separator: " ").map { String($0) }
        return tokens.compactMap { vocab[$0] }  // Convert to token IDs
    }

    func decode(tokens: [Int]) -> String {
        return tokens.compactMap { invVocab[$0] }.joined(separator: " ")
    }
}

