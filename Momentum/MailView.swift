//
//  MailView.swift
//  Momentum
//
//  Created by Aman Gupta on 26/06/25.
//

import Foundation
import SwiftUI
import MessageUI


//struct MailComposeView: UIViewControllerRepresentable {
//    @Binding var isShowing: Bool
//
//    func makeUIViewController(context: Context) -> MFMailComposeViewController {
//        let mail = MFMailComposeViewController()
//        mail.mailComposeDelegate = context.coordinator
//        mail.setToRecipients(["recipient@example.com"])
//        mail.setSubject("Feedback")
//        mail.setMessageBody("<p>Feedback message body</p>", isHTML: true)
//        return mail
//    }
//
//    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
//        var parent: MailComposeView
//
//        init(_ parent: MailComposeView) {
//            self.parent = parent
//        }
//
//        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//            defer {
//                parent.isShowing = false
//            }
//            // Handle the result of the mail sending
//        }
//    }
//}

struct MailView: UIViewControllerRepresentable{
    @Environment(\.dismiss) var dismiss
    
    @Binding var result: Result<MFMailComposeResult, Error>?
    let recipients:[String]
    let subject: String?
    let body: String?
    
    func makeCoordinator() -> Coordinator{
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController{
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setToRecipients(recipients)
        if let subject = subject{
            vc.setSubject(subject)
        }
        if let body = body{
            vc.setMessageBody(body, isHTML: false)
        }
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context){
        
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate{
        var parent: MailView
        
        init(parent: MailView){
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?){
            defer{
                parent.dismiss()
            }
            if let error = error{
                parent.result = .failure(error)
            } else{
                parent.result = .success(result)
            }
        }
        
               
        static func canSendMail() ->Bool {
            MFMailComposeViewController.canSendMail()
        }
    }
}



struct MailViewModifier: ViewModifier{
    @Binding var isPresented: Bool
    let recipients:[String]
    let subject: String?
    let body: String?
    
    @State private var mailResult: Result<MFMailComposeResult,Error>? = nil
    @State private var alertMessage: String? = nil
    @State private var isAlertPresented: Bool = false
    
    func body(content: Content) -> some View{
        content
            .sheet(isPresented: $isPresented){
                MailView(result: $mailResult, recipients: recipients, subject: subject, body: body)
                    .onDisappear{
                        if let result = self.mailResult{
                            switch result{
                            case .success(let mailResult):
                                switch mailResult{
                                case .sent:
                                    alertMessage = "Mail sent successfully"
                                    isAlertPresented = true
                                case .saved:
                                    alertMessage = "Mail saved as draft"
                                    isAlertPresented = true
                                case .cancelled:
                                    alertMessage = "Mail cancelled"
                                    isAlertPresented = true
                                    
                                case .failed:
                                    alertMessage = "Unknown error"
                                    isAlertPresented = true
                                    
                                @unknown default:
                                    alertMessage = "Unknown Error"
                                    isAlertPresented = true
                                }
                            case .failure(let error):
                                alertMessage = error.localizedDescription
                            }
                        }
                        
                    }
                    
                
            }
            .alert(isPresented:$isAlertPresented){
                Alert(title:Text("Mail"),message: Text(alertMessage ?? "Unknown Error"), dismissButton: .default(Text("Ok")))
            }
    }
    
    
}

extension View{
    func mailView(_ isPresented: Binding<Bool>, recipients: [String], subject: String? = nil, body: String? = nil)-> some View{
        modifier(MailViewModifier(isPresented: isPresented, recipients: recipients, subject: subject, body: body))
    }
}
