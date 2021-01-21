//
//  ContentView.swift
//  Calendar
//
//  Created by Стас Жингель on 21.01.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Home : View {
    @State var date = Date()
    @State var data : DateType!
    @State var expand = false
    @State var year = false
    var body: some View {
        GeometryReader {_ in
            VStack{
                Spacer()
                if self.data != nil {
                    HStack {
                        Spacer()
                        ZStack {
                            VStack(spacing: 15) {
                                ZStack {
                                    HStack {
                                        Spacer()
                                        Text(self.data.Month)
                                            .font(.title)
                                            .foregroundColor(.white)
                                        Spacer()
                                        
                                    }
                                    .padding(.vertical)
                                    HStack {
                                        Button(action: {
                                            self.date = Calendar.current.date(byAdding: .month,value: -1, to: self.date)!
                                            self.UpdateDate()
                                        }, label: {
                                            Image(systemName: "arrow.left")
                                        })
                                        Spacer()
                                        Button(action: {
                                            self.date = Calendar.current.date(byAdding: .month,value: 1, to: self.date)!
                                            self.UpdateDate()
                                        }, label: {
                                            Image(systemName: "arrow.right")
                                        })
                                    }
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 30)
                                }
                                .background(Color.red)
                                
                               
                                HStack {
                                    Button(action: {
                                        self.date = Calendar.current.date(byAdding: self.year ? .year : .day ,value: -1, to: self.date)!
                                        self.UpdateDate()
                                    }, label: {
                                        Image(systemName: "arrow.left")
                                    })
                                    Spacer()
                                    VStack {
                                    Text(self.data.Date)
                                                                       .font(.system(size: 65))
                                                                       .fontWeight(.bold)
                                    Text(self.data.Day)
                                                                       .font(.title)
                                    }
                                    Spacer()
                                    Button(action: {
                                        self.date = Calendar.current.date(byAdding: self.year ? .year : .day,value: 1, to: self.date)!
                                        self.UpdateDate()
                                    }, label: {
                                        Image(systemName: "arrow.right")
                                    })
                                }
                                .foregroundColor(.black)
                                .padding(.horizontal, 30)
                               
                                Divider()
                                ZStack {
                                    Text(self.data.Year)
                                        .font(.title)
                                        .padding(.bottom, self.expand ? 15 : 12)
                                        
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            withAnimation(.default) {
                                                self.expand.toggle()
                                            }
                                        }, label: {
                                            Image(systemName: "chevron.right")
                                
                                                .rotationEffect(.init(degrees: self.expand ? 270:90))
                                            
                                        })
                                        .padding([.bottom, .trailing], 20.0)
                                    }
                                }
                                
                                if self.expand {
                                    Toggle(isOn: self.$year, label: {
                                        Text("Year")
                                            .font(.title)
                                          
                                    })
                                    .padding(.horizontal, 15)
                                    .padding([.leading, .bottom], 10.0)
                                   
                                }
                                   
                   
                                
                            }
                            
                            
                            
                            .frame(width: UIScreen.main.bounds.width/1.5)
                            .background(Color.white)
                            .cornerRadius(15)
                        }
                        Spacer()
                    }
                   
                }
                Spacer()
               
            }
        }
        .background(Color.black.opacity(0.06)
                        .edgesIgnoringSafeArea(.all))
        .onTapGesture {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MMM-YYYY"
            print(formatter.string(from: self.date))
        }
        .onAppear {
            self.UpdateDate()
        }
    }
    
    func UpdateDate() {
        let current = Calendar.current
        let date = current.component(.day, from: self.date)
        let monthNO = current.component(.month, from: self.date)
        let month = current.monthSymbols [monthNO - 1]
        let year = current.component(.year, from: self.date)
        let weekNO = current.component(.weekday, from: self.date)
        let day = current.weekdaySymbols [weekNO - 1]
        
        
        
        self.data = DateType(Day: day, Date: "\(date)", Year: "\(year)", Month: month)
    
    }
}
 

struct DateType {
    var Day: String
    var Date: String
    var Year: String
    var Month: String
    
}
