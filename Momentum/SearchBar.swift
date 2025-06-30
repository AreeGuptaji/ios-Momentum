//
//  SearchBar.swift
//  Momentum
//
//  Created by Aman Gupta on 30/06/25.
//

import Foundation
import SwiftUI


struct SearchBar: UIViewRepresentable{
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.placeholder = "Search for a brand"
        searchBar.delegate = context.coordinator
        
        
        return searchBar
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator($text)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate{
        @Binding var text: String
        init(_ text: Binding<String>){
            self._text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
            text = searchText
        }
        
       
        
    }
    
}

