//
//  ContentView.swift
//  ImagePreviewer
//
//  Created by mac book pro on 4/16/21.
//

import SwiftUI

struct ContentView: View {
    @State var isPresenting = false
    var body: some View {
        
        VStack(alignment :.center){
            Spacer()
            Text("Tap here to present").onTapGesture {
                self.isPresenting.toggle()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            
            Spacer()
            
            Text("SwiftUI images viewer\n\(Text("Muayyad Ayesh").font(Font.body.bold()))").multilineTextAlignment(.center)
        }
        .frame(width: UIScreen.main.bounds.width)
        .PanelView(isPresenting: $isPresenting, Image: Image("Trial"), Description: "© Rose image, 2021")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
