import SwiftUI

struct TextFieldRepresentable: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: UIViewRepresentableContext<TextFieldRepresentable>) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.text = text
        textField.placeholder = "ex: jon.smith@email.com"
        textField.font = UIFont(name: "Arial", size: 13)
        textField.adjustsFontSizeToFitWidth = true
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        let toolbar = UIToolbar()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: textField, action: #selector(UIResponder.resignFirstResponder))
        ]
        toolbar.sizeToFit()
        textField.inputAccessoryView = toolbar
        return textField
    }
    


    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldRepresentable>) {
        uiView.text = text
//        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        uiView.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    

    func makeCoordinator() -> TextFieldRepresentable.Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldRepresentable

        init(parent: TextFieldRepresentable) {
            self.parent = parent
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            print("TextField Should Return")
            textField.resignFirstResponder()
            return true
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let currentText = textField.text ?? ""
            
            guard let stringRange = Range(range, in: currentText) else { return false }
            
            // add their new text to the existing text
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

            // make sure the result is under 16 characters
            return updatedText.count <= 100
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }

    }
    
}
