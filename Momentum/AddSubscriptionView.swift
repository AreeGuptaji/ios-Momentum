//
//  AddSubscriptionView.swift
//  Momentum
//
//  Created by Aman Gupta on 27/06/25.
//

import SwiftUI

struct AddSubscriptionView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var searchQuery: String = ""
    
    
    var body: some View {
        NavigationStack{
            ZStack(alignment:.top){
                VStack{
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height:80)
                    List{
                        ForEach(services.filter({searchQuery.isEmpty ? true : $0.name.contains(searchQuery)})){ service in
                            HStack{
                                Image(systemName:"number")
                                Text(service.name)
                                Spacer()
                                Image(systemName:"chevron.right")
                            }
                            .padding(.vertical,10)
                        }
                        
                    }
                    .listStyle(.plain)
                    
                }
                
                
                VStack{
                    
                    HStack(spacing:60){
                        Button(action:{
                            dismiss()
                        }){
                            Text("Cancel")
                        }
                        Text("Add Subscription")
                            .font(.headline)
                        Spacer()
                    }
                    SearchBar(text: $searchQuery)
                    
                
                }
                .background{
                    Color.white
                }
                .padding(.horizontal,20)
            
               
            }
            .padding(.vertical,20)

        }
        
    }
}

#Preview {
    AddSubscriptionView()
}
