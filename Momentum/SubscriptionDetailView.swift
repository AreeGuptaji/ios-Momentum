//
//  SubscriptionDetailView.swift
//  Momentum
//
//  Created by Aman Gupta on 27/06/25.
//

import SwiftUI

struct SubscriptionDetailView: View {
    @State var service: Service = Service(name:"Netflix",icon:"", isPopular:true)
    
    @State var periodOptions:[String] = ["Yearly","Monthly","Weekly","3 Months","6 Months"]
    @State var selectedPeriodOption:Int = 0
    @State var selectedPaymentCurrencyOption:Int = 0
    @State var paymentCurrencyOptions:[String] = ["USD","EUR","INR"]
    @State var cost:String = "0.00"
    
    
    @State var date: Date = Date()
    
    var body: some View {
        NavigationView{
            Form{
                HStack{
                    Spacer()
                    RoundedRectangle(cornerRadius:10)
                        .frame(width:80,height:80)
                        
                    Spacer()
                }.listRowBackground(Color(UIColor.systemGroupedBackground))
                
                
                Section{
                    HStack{
                        Text("Name")
                        Spacer()
                        Text(service.name)
                    }
                }
                Section{
                    
                    HStack{
                        Text("Cost")
                        Spacer()
                        TextField("0.00",text:$cost)
                            .frame(maxWidth:40)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                    }
                    Picker(selection: $selectedPaymentCurrencyOption, label: Text("Currency") ){
                        ForEach(0..<paymentCurrencyOptions.count, id: \.self){ i in
                            Text(paymentCurrencyOptions[i])
                        }
                    }
                    
                    Picker(selection: $selectedPeriodOption, label:Text("Payment Cycle")){
                        ForEach(0..<periodOptions.count, id:\.self){ i in
                            Text(periodOptions[i])
                        }
                    }
                    
                    HStack{
                        Text("First Payment")

                        DatePicker("", selection: $date, displayedComponents: .date)
                            .padding(.horizontal,-12)
                            .padding(.vertical,5)
                    }
                    
                    
                
                }
                
                Section{
                    HStack{
                        Text("Category")
                        Spacer()
                        Text("Streaming")
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement:.navigation){
                    Image(systemName:"chevron.left")
                }
                ToolbarItem(placement: .principal){
                    Text("Add Details")
                        .font(.headline)
                }
            
                ToolbarItem(placement:.automatic){
                    Text("Done")
                        .padding()
                }
            }
            
        }
    
        
        
    }
}

#Preview {
    SubscriptionDetailView()
}





