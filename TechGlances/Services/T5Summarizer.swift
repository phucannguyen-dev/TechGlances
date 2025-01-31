import Foundation
import CoreML

class T5Summarizer {
    private let model: t5_small

    init() {
        do {
            self.model = try t5_small(configuration: MLModelConfiguration())
        } catch {
            fatalError("Failed to load T5 model: \(error)")
        }
    }

    func summarize(text: String) -> String {
        do {
            let inputIds = try MLMultiArray(shape: [1, 128], dataType: .int32)
            let attentionMask = try MLMultiArray(shape: [1, 128], dataType: .int32)
            
            // Fill inputIds and attentionMask with tokenized input (handle this separately)
            
            let output = try model.prediction(input_ids: inputIds, attention_mask: attentionMask)
            
            // Use output.last_hidden_state and convert it into text (requires decoding)
            
            return "Decoded summary text" // Replace with actual decoded result

        } catch {
            print("Error running model: \(error)")
            return "Summarization failed"
        }
    }
}
