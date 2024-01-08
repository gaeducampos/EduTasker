//
//  ProfileView.swift
//  EduTasker
//
//  Created by Gabriel Campos on 7/1/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Button(action: {
                var sceneDelegate: SceneDelegate? {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                        let delegate = windowScene.delegate as? SceneDelegate else { return nil }
                     return delegate
                }
                
                UserDefaults.standard.removeObject(forKey: NetworkProvider.studentInfo)
                sceneDelegate?.window?.rootViewController = SignInViewController()
            }, label: {
                Text("CERRAR SESSION")
            })
        }
    }
}

#Preview {
    ProfileView()
}
