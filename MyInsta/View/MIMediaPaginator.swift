//
//  MIMediaPaginator.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import SwiftUI

struct MIMediaPaginator: View {
    let media: [MIMedia]
    @State private var currentIndex: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentIndex) {
                ForEach(media.indices, id: \.self) { index in
                    MIMediaView(media: media[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            if media.count > 1 {
                HStack(spacing: MIConstants.smallPadding) {
                    ForEach(media.indices, id: \.self) { index in
                        Circle()
                            .fill(index == currentIndex ? MIConstants.Colors.primary : MIConstants.Colors.secondary)
                            .frame(width: MIConstants.Sizes.paginationDot, height: MIConstants.Sizes.paginationDot)
                    }
                }
                .padding(.bottom, MIConstants.smallPadding)
            }
        }
    }
}
