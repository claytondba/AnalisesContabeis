//
//  OpcoesViewController.swift
//  AnalisesContabeis
//
//  Created by Clayton Oliveira on 04/02/19.
//  Copyright © 2019 Clayton Oliveira. All rights reserved.
//

import UIKit

class OpcoesViewController: UIViewController {

    var EmpresaCod: String = ""
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sgLinhas" {
            let vc = segue.destination as! VisaoAnualBarrasViewController
            vc.EmpresaCod = self.EmpresaCod
        }
        else {
            let vc = segue.destination as! VisaoAnualViewController
            vc.EmpresaCod = self.EmpresaCod
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
