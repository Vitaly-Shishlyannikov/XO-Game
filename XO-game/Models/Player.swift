//
//  Player.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public enum Player: CaseIterable {
    case first
    case second
    case comp
    
    var next: Player {
        switch self {
        case .first: return .second
        case .second: return .first
        case .comp: return .comp
        }
    }
    
    var nextFirstAndComp: Player {
        switch self {
        case.first: return .comp
        case.second: return .second
        case .comp: return .first
        }
    }
    
    var markViewPrototype: MarkView {
        switch self {
        case .first:
            return XView()
        case .second:
            return OView()
        case .comp:
            return OView()
        }
    }
}
