//
//  GameEndedState.swift
//  XO-game
//
//  Created by Vitaly_Shishlyannikov on 12.11.2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public class GameEndedState: GameState {
    
    public let isCompleted = false
    
    public let winner: Player?
    private(set) weak var gameViewController: GameViewController?
    
    init(winner: Player?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    
    public func begin() {
        self.gameViewController?.winnerLabel.isHidden = false
        if let winner = winner {
            self.gameViewController?.winnerLabel.text = self.winnerName(from: winner) + " win"
        } else {
            self.gameViewController?.winnerLabel.text = "No winner!"
        }
        self.gameViewController?.firstPlayerTurnLabel.isHidden = true
        self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        self.gameViewController?.compTurnLabel.isHidden = true
        self.gameViewController?.determineLabel.isHidden = true
        
        log(.gameFinished(winner: self.winner))
    }
    
    public func addMark(at position: GameboardPosition) { }
    
    private func winnerName(from winner: Player) -> String {
        switch winner {
        case .first: return "1st player"
        case .second: return "2nd player"
        case .comp: return "comp"
        }
    }
}
