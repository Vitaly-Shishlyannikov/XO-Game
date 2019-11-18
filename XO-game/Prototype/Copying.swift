//
//  Copying.swift
//  XO-game
//
//  Created by Vitaly_Shishlyannikov on 12.11.2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

protocol Copying {
    init(_ ptototype: Self)
}

extension Copying {
    func copy() -> Self {
        return type(of: self).init(self)
    }
}
