
import SwiftUI

struct LoadingView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color(Assests.Color.loaderColor.rawValue))
            .frame(width: 60, height: 60)
            .overlay {
                ProgressView()
                    .progressViewStyle(.circular)
            }
    }
}
