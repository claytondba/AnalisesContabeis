//
//  ResumoViewController.swift
//  AnalisesContabeis
//
//  Created by Clayton Oliveira on 31/01/19.
//  Copyright © 2019 Clayton Oliveira. All rights reserved.
//

import UIKit

class ResumoViewController: UIViewController {

    @IBOutlet weak var fecharButton: UIButton!
    
    @IBAction func ButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
