//
//  LogAction.swift
//  XO-game
//
//  Created by Vitaly_Shishlyannikov on 12.11.2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public enum LogAction {
    
    case playerInput(player: Player, position: GameboardPosition)
    
    case gameFinished(winner: Player?)
    
    case gameFinishedWithPeace()
    
    case restartGame
}

public func log(_ action: LogAction) {
    let command = LogCommand(action: action)
    LoggerInvoker.shared.addLogCommand(command)
}
