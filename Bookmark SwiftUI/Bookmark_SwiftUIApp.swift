import SwiftUI

@main
struct Bookmark_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            if Storage.showOnboarding == true {
                WelcomeView()
            } else {
                MainView()
            }
        }
    }
}
