//
//  SubscriptionListView.swift
//  Momentum
//
//  Created by Aman Gupta on 27/06/25.
//

import SwiftUI

struct SubscriptionListView: View {
    @State var showMonthWiseRates: Bool = true
    @State var showSettingsSheet: Bool = false
    @State var showAddSubscriptionSheet: Bool = false
    @State var gaugeValue: CGFloat = 0.4
    var body: some View {
        ZStack(alignment:.bottomTrailing){
            ScrollView(.vertical){
                VStack{
                    Header
                    ScrollView(.horizontal){
                        HStack{
                            InfoBlock(bgColor:Color.blue,label:"Active",value:"4",icon:"number.circle.fill")
                            InfoBlock(bgColor:Color.purple,label:"Cost/m",value:"1,726",icon:"indianrupeesign.circle.fill")
                             
                        }
                        
                    }
                    .padding(.horizontal,15)
                    
                    VStack{
                        SubscriptionItem(subscriptionName:"Youtube Premium",cost:"195", daysLeft: "17")
                    }
                    .padding(.vertical)
                    
                    Spacer()
                    
                }
            }
            Button(action:{showAddSubscriptionSheet = true}){
                Image(systemName:"plus.circle.fill")
                    .resizable()
                    .frame(width:50,height:50)
                    .foregroundStyle(Color.primary)
            }
            .padding()
        }
        .sheet(isPresented: $showSettingsSheet){
            SettingsView()
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showAddSubscriptionSheet){
            AddSubscriptionView()
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    SubscriptionListView()
}


extension SubscriptionListView{
    private var Header: some View{
        HStack(spacing:30){
            Text("All Subscriptions")
                .foregroundStyle(Color.primary)
            Spacer()
            Button(action:{}){
                Text(showMonthWiseRates ? "/m" : "/y")
                    .foregroundStyle(.white)
                    .background{
                        Circle()
                            .fill(Color.gray.opacity(1))
                            .frame(width:35,height:35)
                    }
                
            }
            Button(action:{}){
                Image(systemName:"arrow.up.arrow.down")
                    .foregroundStyle(.white)
                    .background{
                        Circle()
                            .fill(Color.gray.opacity(1))
                            .frame(width:35,height:35)
                    }
                
            }
            Button(action:{showSettingsSheet = true}){
                Image(systemName:"gear")
                    .foregroundStyle(.white)
                    .background{
                        Circle()
                            .fill(Color.gray.opacity(1))
                            .frame(width:35,height:35)
                    }
            }
            
        }
        .padding(.horizontal,20)
    }
}


struct InfoBlock: View{
    var bgColor: Color = .blue
    var label: String
    var value:String
    var icon: String
    var body: some View{
        HStack{
            HStack{
                Image(systemName:icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:35,height:35)
                VStack(alignment:.leading){
                    Text(value)
                        .fontWeight(.medium)
                    Text(label)
                        .font(.caption)
                        .fontWeight(.light)
                    
                }
            }
            .padding(5)
            .background{
                RoundedRectangle(cornerRadius:10)
                    .fill(bgColor.opacity(0.5))
                    
            }
            Spacer()
        }
    }
}


struct SubscriptionItem: View{
    var icon: String?
    var subscriptionName: String
    var cost: String
    var daysLeft: String
    var gaugeValue: Double = 0.75
    var body: some View{
        HStack{
            RoundedRectangle(cornerRadius:10)
                .fill(Color.random(randomOpacity: true))
                .frame(width:50,height:50)
                .overlay{
                    if let first = subscriptionName.first{
                        Text(String(first).uppercased())
                            .font(.system(size:30))
                            .foregroundStyle(.primary)
                    }
                }
            VStack(alignment: .leading){
                Text(subscriptionName)
                    .fontWeight(.bold)
                    
                
                Text("₹\(cost) /m")
                    .fontWeight(.light)
            }
            VStack{
                
                Gauge(value: gaugeValue){
                    HStack{
                        Spacer()
                        Text("\(daysLeft) days")
                    }
                    .padding(.horizontal,5)
                }
                .accentColor(.gray)
                
            }
        }
        .padding(.horizontal)
    }
}
