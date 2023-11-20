//
//  BeginningViewController.swift
//  Swift_StoryBoard
//
//  Created by digital on 20/11/2023.
//

import UIKit

class BeginningViewController: UIViewController {

    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var monSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func didChange(_ sender: Any) {
        if(monSwitch.isOn){
            switchLabel.text = "on"
        }else{
            switchLabel.text = "off"
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
