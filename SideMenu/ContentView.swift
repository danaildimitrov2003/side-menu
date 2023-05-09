//
//  ContentView.swift
//  SideMenu
//
//  Created by Danail Dimitrov on 9.05.23.
//

import SwiftUI

struct MenuItem: Identifiable{
    var id =  UUID()
    let text: String
    let imageName: String
    let handler: () -> Void = {
        print("Tapped Item")
    }
    
}

struct MenuContent: View{
    let items : [MenuItem] = [
        MenuItem(text: "Home", imageName: "house"),
        MenuItem(text: "Settings", imageName: "gear"),
        MenuItem(text: "Profile", imageName: "person.circle"),
        MenuItem(text: "Activity", imageName: "bell"),
        MenuItem(text: "Flights", imageName: "airplane"),
        MenuItem(text: "Share", imageName: "square.and.arrow.up"),
    ]
    
    var body: some View{
        ZStack{
            Color(UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0 , alpha: 1))
            
            VStack(alignment: .leading, spacing: 0){
                ForEach(items) { item in
                    HStack{
                        Image(systemName: item.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width:32, height: 32, alignment: .center)
                        Text(item.text)
                            .foregroundColor(.white)
                            .bold()
                            .font(.system(size: 22))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .onTapGesture {
                        item.handler()
                    }
                    .padding()
                    Divider()
                }
                Spacer()
            }
            .padding(.top, 35)
        }
    }
}

struct SideMenu: View{
    let width: CGFloat
    let menuOpened: Bool
    let toggleMenu: () -> Void
    
    
    var body: some View{
        ZStack{
            GeometryReader{ _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.15))
            .opacity(self.menuOpened ? 1 : 0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture{
                self.toggleMenu()
            }
            
            HStack{
                MenuContent()
                    .frame(width: width)
                    .offset(x: menuOpened ? 0 : -width)
                    .animation(.default)
                
                Spacer()
            }
        }
    }
}

struct ContentView: View {
    @State var menuOpened = false
    
    var body: some View {
        ZStack {
            if !menuOpened {
                Button(action: {
                    self.menuOpened.toggle()
                },label: {
                    Text("Open Menu")
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color.mint)
                })
             }
            SideMenu(width: UIScreen.main.bounds.width/1.8, menuOpened: menuOpened, toggleMenu: toggleMenu)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func toggleMenu(){
        menuOpened.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
