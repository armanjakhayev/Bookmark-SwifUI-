import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    Image("BG_Image")
                        .resizable()
                        .frame(height: 614, alignment: .top)
                        .aspectRatio(contentMode: .fit)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }.background(.black)
                VStack(spacing: 0){
                    Spacer()
                    Text("See all interesting links in one app")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                        .frame(height: 92, alignment: .leading)
                        .padding(.horizontal, 16)
                        .lineLimit(nil)
                    NavigationLink(destination: MainView(),
                                       label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white)
                                    Text("Let’s start collecting")
                                        .foregroundColor(.black)
                                }
                                .padding(.horizontal)
                                .frame(height: 50)
                        })
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle(" ")
                        .padding(.top, 24)
                        .padding(.bottom, 50)
                        .onTapGesture {
                            Storage.showOnboarding = false
                        }
                }.edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
