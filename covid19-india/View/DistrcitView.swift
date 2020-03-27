import SwiftUI

struct DistrcitView: View {
    var state: StatewiseTally
    
    var body: some View {
        VStack {
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
            
            Divider()
            
            HStack {
                StateRowView(state: state)
            }
            .padding()
            Divider()
            
            HStack {
                Text("District")
                    .font(.caption)
                    .bold()
                Spacer()
                Text("Confirmed")
                    .font(.caption)
                    .bold()
                    .frame(width: 80, height: 10, alignment: .center)
            }
            .padding()
            
            List {
                ForEach(state.districts, id: \.name) { district in
                    HStack{
                        Text(district.name)
                        Spacer()
                        Text(district.confirmed.format())
                    }
                    .padding()
                }
            }
        }
    }
}

struct DistrcitView_Previews: PreviewProvider {
    let decoder = JSONDecoder.init()
    static var previews: some View {
        
        DistrcitView(state: StatewiseTally(state: "Delhi", delta: Delta(confirmed: 1, active: 2, deaths: 3, recovered: 4)))
    }
}
