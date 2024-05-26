import SwiftUI

struct TesterView: View {

    @State var positionX = -150
    
    
    
    var body: some View {
        Rectangle()
            .fill(Color.mint)
            .frame(width: 50, height: 50)
            .offset(x: CGFloat(positionX))
            .animation(.linear(duration: 200).repeatForever(autoreverses: false).speed(4))
            .onAppear(){
                positionX += 250
            }
    }
    
    
}

#Preview {
    TesterView()
}

