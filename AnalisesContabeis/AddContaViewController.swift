//
//  AddContaViewController.swift
//  AnalisesContabeis
//
//  Created by Clayton Oliveira on 20/02/19.
//  Copyright © 2019 Clayton Oliveira. All rights reserved.
//

import UIKit

class AddContaViewController: UIViewController {

    var EmpresaCod: String = ""
    
    @IBOutlet weak var sgDebCred: UISegmentedControl!
    @IBOutlet weak var txtConta: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func fecharButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveConta(_ sender: Any) {
        
        let config = ConfigAnalisesModel()
        
        config.empresa = EmpresaCod
        config.conta = txtConta.text
        config.tipo = sgDebCred.selectedSegmentIndex == 0 ? "C" : "D"
        
        DataManager.saveConfig(cfg: config, onComplete: {(planos) in
            DispatchQueue.main.async {
                
                self.dismiss(animated: true, completion: nil)
            }
            
        })
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
