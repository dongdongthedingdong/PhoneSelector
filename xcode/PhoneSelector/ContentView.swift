//
//  ContentView.swift
//  PhoneSelector
//
//  Created by Matthias Kreier on 10/10/22.
//

import Foundation
import SwiftUI

public struct Phone: Identifiable {
    public var id = UUID()
    public var name: String
    public var phoneType: String
    public var mobilememoryStorage: Int
    public var phoneMass: Double
    public var phonebatteryPower: Int
    public var phonereleaseYear: Int
    public var cost: Double
    public var bestSeller: Bool
    public var image: String?
}

struct ContentView: View { // was PhonesApp
    var phones: [Phone] = PhoneData
    var body: some View{
        NavigationView{
        List{
            ForEach(phones){ phone in
                PhoneCell(phone:phone)
            }
            HStack{
                Spacer()
                Text("\(phones.count) Phones")
                .foregroundColor(.secondary)
                Spacer()
            }
        }
        .navigationBarTitle("Phones")
            Text("Select a phone")
                .font(.largeTitle)
        }
    }
}
struct PhoneDetail: View{
    var phone: Phone
    @State private var zoomed = false
    var body: some View{
        VStack{
            Spacer(minLength:0)
            if let imageFile = phone.image{
                Image(uiImage: UIImage(named: imageFile)!)
                    .resizable()
                    .aspectRatio(contentMode: zoomed ? .fill : .fit)
                    .onTapGesture {
                        withAnimation{
                            self.zoomed.toggle()
        }
                    }
                Spacer()
                Text("Mobile Memory Storage: \(phone.mobilememoryStorage)")
                Text("Mass: \(phone.phoneMass) grams")
                Text("Battery Power: \(phone.phonebatteryPower) mAH")
                Text("Release Year: \(phone.phonereleaseYear)")
                Text("Cost: $\(phone.cost)")
                Spacer(minLength: 0)
                if phone.bestSeller && !zoomed{
                    Spacer(minLength:0)
                    HStack{
                        Spacer()
                        Text("Best Seller")
                        Spacer()
                    }
                    .padding(.all)
                    .font(Font.headline.smallCaps())
                    .background(Color.red)
                    .foregroundColor(.yellow)
                    .transition(.move(edge: .bottom))
                }
                if(phone.cost>=0 && phone.cost<500){
                    Spacer(minLength:0)
                    HStack{
                        Spacer()
                        Text("Cheap")
                        Spacer()
                    }
                    .padding(.all)
                    .font(Font.headline.smallCaps())
                    .background(Color.green)
                    .foregroundColor(.yellow)
                    .transition(.move(edge: .bottom))
                }
                else if(phone.cost>=500 && phone.cost<1000){
                    Spacer(minLength:0)
                    HStack{
                        Spacer()
                        Text("Affordable")
                        Spacer()
                    }
                    .padding(.all)
                    .font(Font.headline.smallCaps())
                    .background(Color.blue)
                    .foregroundColor(.yellow)
                    .transition(.move(edge: .bottom))
                }
                else{
                    Spacer(minLength:0)
                    HStack{
                        Spacer()
                        Text("Expensive")
                        Spacer()
                    }
                    .padding(.all)
                    .font(Font.headline.smallCaps())
                    .background(Color.black)
                    .foregroundColor(.white)
                    .transition(.move(edge: .bottom))
                }
                }
                }
                .navigationBarTitle(phone.name)
                    .edgesIgnoringSafeArea(.bottom)
        }
        }

struct PhoneCell: View{
    var phone: Phone
    var body: some View{
        NavigationLink(destination: PhoneDetail(phone:phone)){
            HStack{
                if let imageFile = phone.image{
                    Image(uiImage: UIImage(named: imageFile)!)
                        .resizable().frame(width:75, height:60)
                        .aspectRatio(contentMode:.fit)
                }
            VStack{
                Text(phone.name)
                Text("\(phone.phoneType)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
