//
//  DemoState.swift
//  XO-game
//
//  Created by Vitaly_Shishlyannikov on 15.11.2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

final class DemoState: GameState {
    
    public private(set) var isCompleted = false
    
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
    
    func begin() {
        
        guard let gameBoardView = self.gameBoardView else {return}
        
        self.gameViewController?.firstPlayerTurnLabel.isHidden = true
        self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        
        let iterator = gameBoardView.iteratorOfMarkNumber
        guard iterator < gameBoardView.positionsSet[player]?.count ?? 5 else {return}

        let positions = gameBoardView.positionsSet[player]
        if let position = positions?[iterator] {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.gameBoardView?.addSavedMark(position: position)
            }
        }
    }
    
    func addMark(at position: GameboardPosition) {
        
        guard let gameBoardView = self.gameBoardView else {return}
        
        self.gameBoard?.setPlayer(self.player, at: position)
        self.gameBoardView?.placeMarkViewAnimated(self.player.markViewPrototype.copy(), at: position)
        self.isCompleted = true
        
        if player == .second {
            gameBoardView.iterateMarkNumber()
        }
    }
}
