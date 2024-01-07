import SwiftUI

struct SignInView: View {
    @StateObject var viewModel: SignInViewModel
    @State private var username = ""
    @State private var password = ""
    var body: some View {
        VStack {
            Text("Sign in your account")
                .font(.custom("Arial", size: 27))
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            
            VStack(spacing: 30) {
                SignInInput(text: "Email", isEmailField: true, value: $username)
                
                SignInInput(text: "Password", isEmailField: false, value: $password)
                
                Button(action: {
                    let credentials = SignInPayload(username: username, password: password)
                    viewModel.performSingIn(with: credentials)
                }, label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green)
                        .frame(height: 40)
                        .overlay {
                            Text("SING IN")
                                .foregroundStyle(.white)
                        }
                })
                
            }
            .padding(.horizontal, 20)
        
            Spacer()
        }
        .overlay {
            if viewModel.isloading {
                LoadingView()
            }
        }
    }
}

private struct SignInInput: View {
    let text: String
    let isEmailField: Bool
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(text)
            
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.gray.opacity(0.05))
                .frame(height: 40)
                .overlay {
                    if isEmailField {
                        TextFieldRepresentable(text: $value)
                    } else {
                        SecureField(" *******", text: $value)
                    }
                }
        }
    }
}

#Preview {
    SignInView(viewModel: .init(service: .init(networkProvider: .init())))
}
