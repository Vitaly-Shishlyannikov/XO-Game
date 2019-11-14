//
//  CompInputState.swift
//  XO-game
//
//  Created by Vitaly_Shishlyannikov on 13.11.2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public class CompInputState: GameState {
    
    public private(set) var isCompleted = false
    
    public let comp: Player
    
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameBoard: Gameboard?
    private(set) weak var gameBoardView: GameboardView?
    
    public let markViewPrototype: MarkView
    
    init(comp: Player, markViewPrototype: MarkView, gameViewController: GameViewController, gameBoard: Gameboard, gameBoardView: GameboardView) {
        self.comp = comp
        self.markViewPrototype = markViewPrototype
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
    }
    
    public func begin() {
        self.gameViewController?.firstPlayerTurnLabel.isHidden = true
        self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        self.gameViewController?.compTurnLabel.isHidden = false
        self.gameViewController?.winnerLabel.isHidden = true
    }
    
    public func addMark(at position: GameboardPosition) {
        guard let gameBoardView = self.gameBoardView,
            gameBoardView.canPlaceMarkView(at: position)
            else {return}
        
        self.gameBoard?.setPlayer(self.comp, at: position)
        self.gameBoardView?.placeMarkView(self.markViewPrototype.copy(), at: position)
        self.isCompleted = true
        
        log(.playerInput(player: self.comp, position: position))
    }
}

