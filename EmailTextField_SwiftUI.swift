// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
@available(iOS 14, macOS 14, *)
struct EmailTextField: View {
    
    var placeholderText: String
    var invalidEmailMessage: String = "Please enter valid email"
    
    @Binding var text: String
    @FocusState var isTextFieldFocused: Bool
    @State private var isValidEmail: Bool = true
    var showIcon: Bool = true
    var textfieldBGColor: Color = .white
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                if showIcon {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.gray)
                }
                    
                TextField(placeholderText, text: $text,  prompt: Text(placeholderText).foregroundColor(.gray))
                    .padding(.leading, showIcon ? 10 : 0)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    
                    .autocorrectionDisabled(true)
                    .focused($isTextFieldFocused)
                    .onChange(of: isTextFieldFocused) {
                        if !isTextFieldFocused {
                            if text.isEmpty {
                                isValidEmail = false
                            }
                            isValidEmail = text.isValidEmail
                        } else {
                            isValidEmail = true
                        }
                }
            }
            .padding()
            .frame(height: 48)
            .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(isValidEmail ? .gray : .red), lineWidth: 1)
            )
            .background(Color(isValidEmail ? textfieldBGColor : .red.opacity(0.3)))
            
            if !isValidEmail {
                Text(invalidEmailMessage)
                    .font(.subheadline)
                    .foregroundStyle(.red)
            }
        }
        
    }
}

@available(iOS 14, macOS 14, *)
#Preview {
    EmailTextField(placeholderText: "Username or Email", text: .constant(""))
}

