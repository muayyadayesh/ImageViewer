//
//  PanelExtension.swift
//  ImagePreviewer
//
//  Created by mac book pro on 4/16/21.
//

import SwiftUI

extension View {
    func PanelView(isPresenting: Binding<Bool>, Image: Image, Description: String = "")-> some View{
        self.modifier(PanelViewModifier(MainImage: Image, isPresenting: isPresenting, Description: Description))
    }
}



struct PanelViewModifier: ViewModifier{
    let MainImage: Image
    @Binding var isPresenting: Bool
    @State var Description: String = ""
    @State var currentScale: CGFloat = 1.0
    @State var previousScale: CGFloat = 1.0
    @State var PageOffset = CGSize.zero
    @State var isTapping = false
    
    func body(content: Content) -> some View {
        
        GeometryReader {reader in
            ZStack(){
                content
                if isPresenting{
                    
                    VStack{
                        HStack{
                            Spacer()
                            Image(systemName: "x.circle.fill").font(.title).foregroundColor(.white).onTapGesture {
                                self.isPresenting = false
                            }
                            .opacity(isTapping ? 0 : 0.8)
                        }
                        .padding()
                        
                        Spacer()
                        MainImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(self.currentScale)
                            .gesture(MagnificationGesture()
                                        .onChanged { value in
                                            let delta = value / self.previousScale
                                            previousScale = value
                                            currentScale = self.currentScale * delta
                                            isTapping = true
                                        }
                                        .onEnded { value in self.currentScale = 1.0
                                            isTapping = false
                                        })
                        
                        if !Description.isEmpty{
                            Text(Description)
                                .lineLimit(1)
                                .padding(.horizontal, 10)
                                .background(Color.white)
                                .foregroundColor(Color.black)
                                .clipShape(Capsule())
                                .padding(.horizontal)
                                .opacity(isTapping ? 0 : 1)
                        }
                        
                        Spacer()
                        
                    }
                    .frame(width: reader.size.width, height: reader.size.height)
                    .offset(y: self.PageOffset.height)
                    .background(Color.black)
                    .onAppear{
                        previousScale = 1.0
                        PageOffset.height = .zero
                    }
                    .gesture(DragGesture().onChanged{ (value) in
                        PageOffset.height = value.translation.height
                        isTapping = true
                    }
                    .onEnded{ (value) in
                        if value.translation.height > 100 {
                            isPresenting = false
                        }
                        isTapping = false
                        PageOffset.height = .zero
                    })
                    
                }
            }
            .animation(.easeInOut(duration: 0.3))
            
        }
    }
    
}
