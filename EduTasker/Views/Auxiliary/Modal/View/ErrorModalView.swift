//
//  ErrorModalView.swift
//  EduTasker
//
//  Created by Gabriel Campos on 7/1/24.
//

import SwiftUI

struct ErrorModalView: View {
    var text: String
    var action: ()->Void
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .frame(height: 200)
                .overlay {
                    VStack {
                        Image(Assests.Image.closeIcon.rawValue)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .onTapGesture {
                                action()
                            }
                        
                        Spacer()
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topTrailing)
                    
                    VStack {
                        Image(Assests.Image.errorIcon.rawValue)
                            .resizable()
                            .frame(width: 70, height: 70)
                        
                        Text(text)
                            .padding(.horizontal)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                    }
                }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ErrorModalView(text: "Lo sentimos algo salio mal. Intenta de nuevo.") {}
}
