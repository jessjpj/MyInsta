//
//  MIDataServiceSelector.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import Foundation

class MIDataServiceSelector {
    func decideDataService() -> MIDataService {
        #if MIOFFLINE
            return JSONService()
        #endif
            return MIFirestoreService()
    }
    
}
