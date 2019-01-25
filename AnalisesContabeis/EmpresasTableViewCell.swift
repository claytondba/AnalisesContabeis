//
//  EmpresasTableViewCell.swift
//  AnalisesContabeis
//
//  Created by Clayton Oliveira on 09/12/18.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class EmpresasTableViewCell: UITableViewCell {

    
    @IBOutlet weak var responsavelLabel: UILabel!
    @IBOutlet weak var cnpjLabel: UILabel!
    @IBOutlet weak var empresaLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func PrepareCell(empresa: EmpresasModel){
        
        if let razao = empresa.razao {
            empresaLabel.text = "(\(empresa.codigo!)) \(razao)"
        }
        if let responsavel = empresa.nome_titular {
            responsavelLabel.text = responsavel
        }
        if let cnpj = empresa.cnpj {
            cnpjLabel.text = "CNPJ: \(cnpj)"
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
