//
//  PlanosTableViewCell.swift
//  AnalisesContabeis
//
//  Created by Clayton Oliveira on 09/12/18.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class PlanosTableViewCell: UITableViewCell {

    
    @IBOutlet weak var contaLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var valorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func Preparecell(plano: PlanosModel){
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "R$ "
        formatter.alwaysShowsDecimalSeparator = true
        
        if let conta = plano.conta {
            contaLabel.text = conta
        }
        
        if let descricao = plano.descricao{
            descricaoLabel.text = descricao
        }
        
        if let valor = plano.valor {
            let receitaValor = formatter.string(for: valor)!
            valorLabel.text = "\(receitaValor)"
        }
    }
    
}
