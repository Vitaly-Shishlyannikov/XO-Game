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
    
    public private(set) var needToCheckWinner = false
    
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
        self.gameViewController?.determineLabel.isHidden = false
        
        let iterator = gameBoardView.iteratorOfMarkNumber
        if iterator == 5 {
            self.needToCheckWinner = true
            self.gameViewController?.goToNextState()
        }
        guard iterator < gameBoardView.positionsSet[player]?.count ?? 5 else {return}

        let positions = gameBoardView.positionsSet[player]
        if let position = positions?[iterator] {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.gameBoardView?.addSavedMark(position: position)
            }
        }
    }
    
    func addMark(at position: GameboardPosition) {
        
        guard let gameBoardView = self.gameBoardView else {return}
        
        self.gameBoard?.setPlayer(self.player, at: position)
        self.gameBoardView?.placeMarkViewWithRemoving(self.player.markViewPrototype.copy(), at: position)
        self.isCompleted = true
        
        if player == .second {
            gameBoardView.iterateMarkNumber()
        }
    }
}
