//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var compTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!

    private let gameBoard = Gameboard()
    
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    private lazy var referee = Referee(gameboard: self.gameBoard)

    public var gameMode: GameMode = .withHuman
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch self.gameMode {
        case .withComp: self.goToFirstState()
        case .withHuman: self.goToFirstState()
        case .with5Marks: self.goTo5MarksState()
        }
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                self.goToNextState()
            }
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        self.gameboardView.clear()
        self.gameBoard.clear()
        
        self.goToFirstState()
        
        log(.restartGame)
    }
    
    private func goTo5MarksState() {
        let player = Player.first
        self.currentState = PlayerInput5MarksState(player: player,
                                             markViewPrototype: player.markViewPrototype,
                                             gameViewController: self,
                                             gameBoard: gameBoard,
                                             gameBoardView: gameboardView)
    }
    
    private func goToFirstState() {
        let player = Player.first
        self.currentState = PlayerInputState(player: player,
                                             markViewPrototype: player.markViewPrototype,
                                             gameViewController: self,
                                             gameBoard: gameBoard,
                                             gameBoardView: gameboardView)
    }
    
    private func checkWinner() {
        if let winner = self.referee.determineWinner() {
            self.currentState = GameEndedState(winner: winner, gameViewController: self)
            return
        }
    }
    
    private func checkPeacefulEnd() {
        if gameboardView.markViewForPosition.count == GameboardSize.square {
            self.currentState = GamePeacefulEndedState(gameViewController: self)
            return
        }
    }
    
    private func goToNextState() {
        
        switch gameMode {
        case .withHuman:
            
            self.checkWinner()
            self.checkPeacefulEnd()
            
            if let playerInputState = currentState as? PlayerInputState {
                let player = playerInputState.player.next
                self.currentState = PlayerInputState(player: player,
                                                     markViewPrototype: player.markViewPrototype,
                                                     gameViewController: self,
                                                     gameBoard: gameBoard,
                                                     gameBoardView: gameboardView)
            }

        case .withComp:
            
            self.checkWinner()
            self.checkPeacefulEnd()
            
            if currentState is PlayerInputState {
                if let state = currentState as? PlayerInputState {
                    let comp = state.player.nextFirstAndComp
                    self.currentState = CompInputState(comp: comp,
                                                       markViewPrototype: comp.markViewPrototype,
                                                       gameViewController: self,
                                                       gameBoard: gameBoard,
                                                       gameBoardView: gameboardView)
                }
                
            } else if currentState is CompInputState {
                if let state = currentState as? CompInputState {
                    let player = state.comp.nextFirstAndComp
                    self.currentState = PlayerInputState(player: player,
                                                         markViewPrototype: player.markViewPrototype,
                                                         gameViewController: self,
                                                         gameBoard: gameBoard,
                                                         gameBoardView: gameboardView)
                }
            }

        case .with5Marks:
            
            if let playerInputState = currentState as? PlayerInput5MarksState {
                let player = playerInputState.player.next
                self.currentState = PlayerInput5MarksState(player: player,
                                                           markViewPrototype: player.markViewPrototype,
                                                           gameViewController: self,
                                                           gameBoard: gameBoard,
                                                           gameBoardView: gameboardView)
            }
        }
    }
}

