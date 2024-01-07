
import SwiftUI

struct LoadingView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.blue)
            .frame(width: 60, height: 60)
            .overlay {
                ProgressView()
                    .progressViewStyle(.circular)
            }
    }
}
