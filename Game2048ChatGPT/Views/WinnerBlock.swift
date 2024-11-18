import SwiftUI

struct WinnerBlock: View {
    private let title = "2048"
   // @State var settings:  Settings
    @Binding var settings:  Settings
    @State private var showSettings = false
    
    var body: some View {
        HStack {
            Text("2048")
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
            settingsView
        }
   
      
    }
    
    var settingsView: some View {
        Button(action: {self.showSettings = true}) {
            Image(systemName:"gearshape" )
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.colorBG)
             //   .background(Color.red)
                .frame(maxWidth: .infinity, maxHeight: 50)
             }
        .sheet(isPresented: $showSettings) {
            SettingView (settings:  $settings, isPresented: $showSettings)
        }
    }
}

#Preview{
    WinnerBlock(settings: .constant( Settings()))
    }

