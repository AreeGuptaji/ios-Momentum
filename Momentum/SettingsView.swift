//
//  SettingsView.swift
//  Momentum
//
//  Created by Aman Gupta on 26/06/25.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    @State var simplifiedCosts: Bool = false
    @State var groupPaymentsCycle: Bool = false
    private var displayCurrencies:[String] = ["INR","USD","EUR"]
    @State var selectedCurrency:Int = 0
    @State var isShowingMailSheet: Bool = false
    @State private var showingMailAlert: Bool = false
    @State private var mailAlertMessage: String = ""
    
    
    var body: some View {
        NavigationStack{
            Form{
                generalSection
                supportSection
                Section(header: Text("Community")){
                    
                }
                
            }
            .navigationBarTitle(Text("Settings"))
        }
        
        .mailView($isShowingMailSheet, recipients:["aman@naviteklabs.com"])
        .alert("Mail Unavailable", isPresented: $showingMailAlert) {
            Button("Copy Email", action: copyEmailToClipboard)
            Button("OK", role: .cancel) { }
        } message: {
            Text(mailAlertMessage)
        }
    }
}

#Preview {
    SettingsView()
}

// MARK: - Helper Methods
extension SettingsView {
    private func handleGetInTouch() {
        if MFMailComposeViewController.canSendMail() {
            isShowingMailSheet = true
        } else {
            mailAlertMessage = "Mail is not configured on this device. You can copy the email address to contact us through your preferred email app."
            showingMailAlert = true
        }
    }
    
    private func copyEmailToClipboard() {
        UIPasteboard.general.string = "aman@naviteklabs.com"
    }
}

// General Section
extension SettingsView{
    var generalSection: some View{
        Section(header: Text("General")){
            Picker(selection:$selectedCurrency, label: Label{Text("Currency")}icon: {
                ZStack{
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.green)
                        .frame(width:30,height:30)
                    Image(systemName: "dollarsign")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                    
                }
            }){
                ForEach(0..<displayCurrencies.count, id:\.self){
                    Text(self.displayCurrencies[$0])
                }
            }
            Toggle(isOn: $simplifiedCosts){
                Label{Text("Currency")}icon: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.blue.opacity(0.5))
                            .frame(width:30,height:30)
                        Image(systemName: "dollarsign.arrow.trianglehead.counterclockwise.rotate.90")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                        
                    }
                }
            }
            Toggle(isOn: $groupPaymentsCycle){
                Label{Text("Group by payment cycle")}icon: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.purple.opacity(0.5))
                            .frame(width:30,height:30)
                        Image(systemName: "circle.dotted")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                        
                    }
                }
            }
            HStack{
                Label{Text("Dark Mode")}icon: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.orange.opacity(0.8))
                            .frame(width:30,height:30)
                        Image(systemName: "moon.zzz")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                        
                    }
                }
                Spacer()
                Text("System")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

extension SettingsView{
    private var supportSection: some View{
        Section(header:Text("Support")){
            Button(action:{handleGetInTouch()}){
                Label{Text("Get in touch").foregroundStyle(Color.primary)}icon: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.blue.opacity(0.8))
                            .frame(width:30,height:30)
                        Image(systemName: "mail.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                        
                    }
                }
            }
        }
    }
}
