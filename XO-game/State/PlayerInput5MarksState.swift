//
//  PlayerInput5MarksState.swift
//  XO-game
//
//  Created by Vitaly_Shishlyannikov on 14.11.2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public class PlayerInput5MarksState: GameState {
    
    public private(set) var isCompleted = false
    
    public private(set) var allMarksAdded = false
    
    public let player: Player
    
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameBoard: Gameboard?
    private(set) weak var gameBoardView: GameboardView?
    
    public let markViewPrototype: MarkView
    
    init(player: Player, markViewPrototype: MarkView, gameViewController: GameViewController, gameBoard: Gameboard, gameBoardView: GameboardView) {
        self.player = player
        self.markViewPrototype = markViewPrototype
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
    }
    
    public func begin() {
        switch self.player {
        case .first:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.secondPlayerTurnLabel.isHidden = true
            self.gameViewController?.compTurnLabel.isHidden = true
        case .second:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
            self.gameViewController?.compTurnLabel.isHidden = true
        case .comp:
            return
        }
        self.gameViewController?.winnerLabel.isHidden = true
    }
    
    public func addMark(at position: GameboardPosition) {
        
        guard let gameBoardView = self.gameBoardView else {return}
        
        self.gameBoard?.setPlayer(self.player, at: position)
        self.gameBoardView?.addMarkToSet(for: self.player, self.markViewPrototype.copy(), at: position)
        
        if gameBoardView.positionsSet[player]?.count == 5 {
        
            switch player {
            case .first:
                self.isCompleted = true
            case .second:
                self.isCompleted = true
                self.allMarksAdded = true
            case .comp:
                return
            }
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let subViews = gameBoardView.subviews
                subViews.forEach {$0.removeFromSuperview()}
//            }
        }
//        log(.playerInput(player: self.player, position: position))
    }
}

