//
//  LogCommand.swift
//  XO-game
//
//  Created by Vitaly_Shishlyannikov on 12.11.2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

// Mark: - Command

final class LogCommand {
    
    let action: LogAction
    
    init(action: LogAction) {
        self.action = action
    }
    
    var logMessage: String {
        switch self.action {
        case .playerInput(let player, let position):
            return "\(player) placed mark at \(position)"
        case .gameFinished(let winner):
            return "\(String(describing: winner)) win game"
        case .gameFinishedWithPeace():
            return "Game finished with peace"
        case .restartGame:
            return "Game was restarted"
        }
    }
}
