import SwiftUI

struct MainView: View {
    @State var showSaveSheet = false
    @State var bookmarkModels:[BookmarkModel] = Storage.bookmarkModels
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ZStack {
            VStack(spacing: 0){
                Text(bookmarkModels.isEmpty ? "Bookmark App" : "List")
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .frame(height: 22)
                    .padding(.top, 56)
                if bookmarkModels.isEmpty {
                    Spacer()
                    Title1()
                    Spacer()
                } else {
                    VStack (spacing: 0){
                        List(){
                            ForEach(bookmarkModels, id: \.self) { bookmarkModel in
                                HStack(spacing: 0){
                                    Text("\(bookmarkModel.title)")
                                        .font(.system(size: 17))
                                    Spacer()
                                    Image("Group")
                                }
                                .padding(.top, 39)
                                .padding(.bottom,11)
                                .onTapGesture {
                                    openURL(URL(string: bookmarkModel.linkURL)!)
                                }
                            }.onDelete(perform: delete)
                                .listRowBackground(Color("MyGray"))
                        }
                        .listStyle(.grouped)
                    }
                    Spacer()
                }
                Button(action: {
                    self.showSaveSheet = true
                }){
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.black)
                        Text("Add bookmark")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }.frame(height: 58)
                        .padding(.horizontal)
                }
                .padding(.bottom, 50)
            }.background(Color("MyGray"))
            .edgesIgnoringSafeArea(.all)
            
            BottomSheet(isShowing: $showSaveSheet, bookmarkModels: $bookmarkModels)
        }
    }
    
    func delete (at offsets: IndexSet) {
        bookmarkModels.remove(atOffsets: offsets)
        Storage.bookmarkModels.remove(atOffsets: offsets)
    }
}

struct Title1: View {
    var body: some View {
        Text("Save your first\n bookmark")
        .font(.system(size: 36, weight: .bold))
        .foregroundColor(.black)
        .frame(height: 92)
        .multilineTextAlignment(.center)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
