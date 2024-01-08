import SwiftUI

struct SignInView: View {
    @StateObject var viewModel: SignInViewModel
    @State private var username = ""
    @State private var password = ""
    
    private func setupSignBackgroundButtonColor() -> Color {
        if username.isEmpty || password.isEmpty {
            return .gray.opacity(0.5)
        } else {
            return Color(Assests.Color.appThemeColor.rawValue)
        }
    }
    
    private func setupSignTextButtonColor() -> Color {
        if username.isEmpty || password.isEmpty {
            return .black
        } else {
            return Color(Assests.Color.darkTextColor.rawValue)
        }
    }
    
    var body: some View {
        VStack {
            Text("Bienvenido a EduTasker")
                .font(.custom("Arial", size: 27))
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            
            Image(Assests.Image.appIconNoBg.rawValue)
                .resizable()
                .frame(width: 200, height: 200)
                .scaledToFit()
            
            Text("Inicia Sesión con tu cuenta UFG")
                .font(.custom("Arial", size: 27))
                .fontWeight(.semibold)
                .minimumScaleFactor(0.1)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            VStack(spacing: 30) {
                SignInInput(text: "usuario", isEmailField: true, value: $username)
                
                SignInInput(text: "contraseña", isEmailField: false, value: $password)
                
                Button(action: {
                    let credentials = SignInPayload(username: username, password: password)
                    viewModel.performSingIn(with: credentials)
                }, label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(setupSignBackgroundButtonColor())
                        .frame(height: 40)
                        .overlay {
                            Text("SING IN")
                                .fontWeight(.semibold)
                                .foregroundStyle(setupSignTextButtonColor())
                        }
                })
                .disabled(username.isEmpty || password.isEmpty)
                .padding(.bottom)
                
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
