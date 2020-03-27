import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            
            Text(viewModel.fact.0)
                .padding()
                .font(.caption)
                .multilineTextAlignment(.center)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 70, alignment: .center)
            
            Divider()
            
            HStack {
                Text("State/UT")
                    .font(.caption)
                    .bold()
                Spacer()
                Text("Confirmed")
                    .font(.caption)
                    .bold()
                    .frame(width: 80, height: 10, alignment: .center)
                Text("Active")
                    .font(.caption)
                    .bold()
                    .frame(width: 60, height: 10, alignment: .center)
                Text("Recovered")
                    .font(.caption)
                    .bold()
                    .frame(width: 70, height: 10, alignment: .center)
                Text("Deaths")
                    .font(.caption)
                    .bold()
                    .frame(width: 50, height: 10, alignment: .center)
            }
            .padding()
            
            if viewModel.totalRow != nil {
                HStack {
                    StateRowView(state: viewModel.totalRow!)
                }
                .padding()
                
                Divider()
            }
            
            List {
                ForEach(viewModel.basicData.statewise, id: \.state) { state in
                    HStack{
                        StateRowView(state: state)
                    }
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                }
            }
        }
        .onAppear {
            self.viewModel.fetchData()
            self.viewModel.getFacts()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct StateRowView: View {
    @State var state: StatewiseTally
    
    var body: some View {
        HStack {
            
            Text(state.state)
                .font(.caption)
                .bold()
            Spacer()
            
            NegativeState(value: state.confirmed, delta: state.delta.confirmed)
                .frame(width: 80, height: 10, alignment: .center)
            
            NegativeState(value: state.active, delta: state.delta.active)
                .frame(width: 60, height: 10, alignment: .center)
            
            VStack {
                Text(state.recovered.format())
                if (state.delta.recovered > 0) {
                    HStack {
                        Image(systemName: "arrow.up")
                            .resizable()
                            .foregroundColor(.green)
                            .frame(width: 10, height: 10, alignment: .center)
                        Text(state.delta.recovered.format())
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }
                else {
                    HStack {
                        Image(systemName: "minus.rectangle")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 10, height: 10, alignment: .center)
                    }
                }
            }
            .frame(width: 70, height: 10, alignment: .center)
            
            NegativeState(value: state.deaths, delta: state.delta.deaths)
                .frame(width: 50, height: 10, alignment: .center)
            
        }
    }
}


struct NegativeState: View {
    
    @State var value: Int
    @State var delta: Int
    
    var body: some View {
        VStack {
            Text(value.format())
            if (delta > 0) {
                HStack {
                    Image(systemName: "arrow.up")
                        .resizable()
                        .foregroundColor(.red)
                        .frame(width: 10, height: 10, alignment: .center)
                    Text(delta.format())
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            else {
                HStack {
                    Image(systemName: "minus.rectangle")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 10, height: 10, alignment: .center)
                }
            }
        }
    }
}
