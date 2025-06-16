import SwiftUI

struct StationField: View {
    var stationData: StationData
    var didSelect: () -> Void

    var body: some View {
        Button(action: didSelect) {
            Text(stationData.description)
                .foregroundStyle(
                    (stationData.station != nil)
                    ? Color.black
                    : Color.gray
                )
                .lineLimit(1)
        }
    }
}
