import SwiftUI

struct BottomSheet: View {
    @Binding var isShowing: Bool
    @Binding var bookmarkModels: [BookmarkModel]
    
    var body: some View {
        ZStack(alignment: .bottom){
            if isShowing{
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                VStack{
                    Spacer()
                    SaveSheet(bookmarkModels: $bookmarkModels, showSaveSheet: $isShowing, isShowing: $isShowing)
                }
                .transition(.move(edge: .bottom))
                .ignoresSafeArea()
                .animation(.easeInOut)
            }
        }
        .gesture(DragGesture(minimumDistance: 30, coordinateSpace: .local).onEnded({ value in
            if value.translation.height > 0 && value.translation.width < 100 && value.translation.width > -100 {
                isShowing = false
            }
        }))
    }
}

struct SaveSheet: View {
    @Binding var bookmarkModels: [BookmarkModel]
    @Binding var showSaveSheet: Bool
    @Binding var isShowing: Bool
    @State var title: String = ""
    @State var link: String = ""
    @State var textFieldOffSet = 0.0
    @State var textIntextField = ""
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(height: 362)
            VStack(spacing:0){
                HStack(spacing:0){
                    Spacer()
                        Image(systemName: "xmark")
                            .frame(width: 12, height: 12)
                            .padding(.leading ,6)
                            .onTapGesture {
                                isShowing = false
                            }
                }
                HStack(spacing:0){
                    Text("Title")
                        .font(.system(size: 17))
                        .padding(.top,22)
                    Spacer()
                }
                TextField("Bookmark title", text: $title)
                    .frame(height: 46)
                    .font(.system(size: 17))
                    .padding(.horizontal)
                    .background(Color("MyGray"))
                    .cornerRadius(12)
                    .padding(.top, 12)
                    .onTapGesture {
                        if textIntextField == "" {
                        textFieldOffSet = -340.0
                        }
                    }
                HStack(spacing:0){
                    Text("Link")
                        .font(.system(size: 17))
                        .padding(.top)
                    Spacer()
                }
                TextField("Bookmark link (URL)", text: $link)
                    .autocapitalization(.none)
                    .frame(height: 46)
                    .font(.system(size: 17))
                    .padding(.horizontal)
                    .background(Color("MyGray"))
                    .cornerRadius(12)
                    .padding(.top, 12)
                    .onTapGesture {
                        if textIntextField == "" {
                        textFieldOffSet = -340.0
                        }
                    }
                Button(action: {
                    saveLink(title: title, link: link)
                    isShowing = false
                }){
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.black)
                        Text("Save")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }.frame(height: 58)
                }
                    .padding(.top, 24)
            }
            .frame(height: 362)
            .padding(.horizontal)
            .edgesIgnoringSafeArea(.all)
        }.offset(y: textFieldOffSet)
    }
    func saveLink(title: String, link: String){
        let bookmarkModel = BookmarkModel(title: title, linkURL: link)
        bookmarkModels.append(bookmarkModel)
        Storage.bookmarkModels.append(bookmarkModel)
    }
}
