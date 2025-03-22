//
//  MIProfilePicture.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import SwiftUI

struct MIProfilePicture: View {
    let imageURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { image in
            image.resizable()
        } placeholder: {
            MIConstants.Colors.gray
        }
        .frame(width: MIConstants.Sizes.profilePicture, height: MIConstants.Sizes.profilePicture)
        .clipShape(Circle())
    }
}
