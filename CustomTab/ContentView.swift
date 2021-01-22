//
//  ContentView.swift
//  CustomTab
//
//  Created by 亚飞 on 2021/1/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            CustomTabView()
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





struct CourseCardView : View {
    
    var course : Course
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                Image(course.asset)
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                
                HStack {
                    
                    VStack(alignment: .leading, spacing: 12, content: {
                        
                        Text(course.name)
                            .fontWeight(.bold)
                        
                        Text("\(course.numCourse) Courses")
                            .font(.subheadline)
                        
                        
                    })
                    .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding()
                
                
            }
            .background(Color.white)
            .cornerRadius(15)
            
            Spacer()
        }
        
    }
    
}

struct Course : Identifiable {
    var id = UUID().uuidString
    var name : String
    var numCourse : Int
    var asset : String
    
}



var courses = [
    
    Course(name: "onePiece", numCourse: 12, asset: "onePiece"),
    Course(name: "onePiece1", numCourse: 12, asset: "onePiece1"),
    Course(name: "onePiece2", numCourse: 12, asset: "onePiece2"),
    Course(name: "onePiece3", numCourse: 12, asset: "onePiece3"),
    Course(name: "onePiece4", numCourse: 12, asset: "onePiece4"),
    Course(name: "onePiece3", numCourse: 12, asset: "onePiece3"),
    Course(name: "onePiece1", numCourse: 12, asset: "onePiece1"),
    Course(name: "onePiece2", numCourse: 12, asset: "onePiece2"),
    
]




//MARK: Tab
struct CustomTabView : View {
    
    @State var selectedTab = tabs[0]
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            
//            Home()
            
            TabView(selection: $selectedTab,
                    content:  {
                        Home()
                            .tag("house.fill")
                        
                        Paperplane()
                            .tag("paperplane")
                        
                        Bookmark()
                            .tag("bookmark")
                        
                        Person()
                            .tag("person.crop.square")
                        
                    })
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .ignoresSafeArea(.all, edges: .bottom)
            
            
            
            
            HStack(spacing: 0) {
                
                ForEach(tabs, id: \.self) { imageName in
                    
                    TabButton(imageName: imageName, selectedTab: $selectedTab)
                    
                    
                    if imageName != tabs.last {
                        
                        Spacer()
                    }
                    
                    
                }
                
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 5)
            .background(Color.white)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: -5)
            .padding(.horizontal)
            .padding(.bottom, edge!.bottom == 0 ? 20 : 0)
            
            //无视tab升高
            
            
            
        })
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(Color.black.opacity(0.05).ignoresSafeArea(.all))
        
        
    }
    
}


var tabs = ["house.fill", "paperplane", "bookmark", "person.crop.square"]

struct TabButton : View {
    
    var imageName : String
    @Binding var selectedTab : String
    
    var body: some View {
       
        Button(action: {
            selectedTab = imageName
        }, label: {
            Image(systemName: imageName)
                .renderingMode(.template)
                .foregroundColor(selectedTab == imageName ? Color.blue : Color.gray)
                .padding()
            
        })
        
    }
    
}


//MARK: TabViews....

struct Home : View {
    
    @State  var text = ""
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Hello Carlos")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Let's upgrade your skill!")
                    
                }
                .foregroundColor(.black)
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(uiImage: #imageLiteral(resourceName: "album"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .cornerRadius(5)
                        .clipped()
                })

                    
                
                
            }
            .padding()
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack {
                    
                    HStack (spacing:15){
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search Courses", text: $text)
                        
                        
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(Color.white)
                    .clipShape(Capsule())
                    
                    HStack (spacing:15){
                        
                        Text("Categories")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        
                        Button(action: {}, label: {
                            Text("View All")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        })
                                        
                    }
                    .padding(.vertical, 20)
                    
                    
                    
                    
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2),spacing: 20,content: {
                        
                        ForEach (courses) { course in
                            
                            NavigationLink(
                                destination: DetailView(course: course),
                                label: {
                                    CourseCardView(course: course)
                                })
                            
                            
                        }
                        
                    })
                    
                }
                .padding(.horizontal)
                .padding(.bottom, edge!.bottom + 70)
                
                
                 
            })
            
            
            
        }
    }
    
    
}


struct Paperplane : View {
    
    var body: some View {
        
        Text("Paperplane")
    }
    
}

struct Bookmark : View {
    
    var body: some View {
        
        Text("Bookmark")
    }
    
}

struct Person : View {
    
    var body: some View {
        
        Text("Person")
    }
    
}


struct DetailView : View {
    
    var course : Course
    
    var body: some View {
        
        VStack {
            
            Text(course.name)
                .font(.title)
                .fontWeight(.bold)
            
        }
        .navigationBarTitle(course.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {}, label: {
            Image(systemName: "list.dash")
                .renderingMode(.template)
                .foregroundColor(.gray)
        }))
        
        
    }
    
    
}
