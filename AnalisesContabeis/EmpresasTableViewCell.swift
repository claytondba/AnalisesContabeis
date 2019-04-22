//
//  EmpresasTableViewCell.swift
//  AnalisesContabeis
//
//  Created by Clayton Oliveira on 09/12/18.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class EmpresasTableViewCell: UITableViewCell {

    
 
    @IBOutlet weak var cnpjLabel: UILabel!
    @IBOutlet weak var empresaLabel: UILabel!
    @IBOutlet weak var planoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func PrepareCell(empresa: EmpresasModel){
        
        if let razao = empresa.razao {
            empresaLabel.text = "(\(empresa.codigo!)) \(razao)"
        }
        if let cnpj = empresa.cnpj {
            cnpjLabel.text = "CNPJ: \(cnpj)"
        }
        if let plano = empresa.planoproprio {
            planoLabel.text = plano
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
