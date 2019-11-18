//
//  MainMenuViewController.swift
//  XO-game
//
//  Created by Vitaly_Shishlyannikov on 13.11.2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

final class MainMenuViewController: UIViewController {
    
    @IBAction func backToMainMenu(unwindSegue: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "StartWithCompSegue"){
            guard let vc = segue.destination as? GameViewController else {return}
            vc.gameMode = .withComp
        }
        
        if(segue.identifier == "Start5MarksGame"){
            guard let vc = segue.destination as? GameViewController else {return}
            vc.gameMode = .with5Marks
        }
    }
}
