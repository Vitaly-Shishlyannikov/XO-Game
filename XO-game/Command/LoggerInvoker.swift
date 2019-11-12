//
//  LoggerInvoker.swift
//  XO-game
//
//  Created by Vitaly_Shishlyannikov on 12.11.2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

// Mark: - Invoker

internal final class LoggerInvoker {
    
    internal static let shared = LoggerInvoker()
    
    private let logger = Logger()
    
    private let batchSize = 10
    
    private var commands: [LogCommand] = []
    
    internal func addLogCommand(_ command: LogCommand) {
        self.commands.append(command)
        self.executeComandsIfNeeded()
    }
    
    private func executeComandsIfNeeded() {
        guard self.commands.count >= batchSize else {return}
        
        self.commands.forEach{ self.logger.writeMassageToLog($0.logMessage)}
        self.commands = []
    }
}

