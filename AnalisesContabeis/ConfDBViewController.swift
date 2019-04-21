//
//  ConfDBViewController.swift
//  AnalisesContabeis
//
//  Created by Clayton Oliveira on 21/04/19.
//  Copyright © 2019 Clayton Oliveira. All rights reserved.
//

import UIKit

class ConfDBViewController: UIViewController {

    //Controles
    @IBOutlet weak var pickerConf: UIPickerView!
    
    
    //Configiração no PV
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        
        //Valores do PV
        pickerData = ["Candinho - Matriz", "Candinho - Filial"]
        self.pickerConf.delegate = self
        self.pickerConf.dataSource = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func FecharButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
extension ConfDBViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerData[row] == "Candinho - Matriz" {
            Configuration.shared.TokenAPI = "http://server.candinho.com.br/rob/api/"
        }
        else if pickerData[row] == "Candinho - Filial" {
            Configuration.shared.TokenAPI = "http://server.candinho.com.br/filial/api/"
        }
        
    }
    
}
