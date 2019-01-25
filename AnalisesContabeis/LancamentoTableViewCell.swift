//
//  LancamentoTableViewCell.swift
//  AnalisesContabeis
//
//  Created by Clayton Oliveira on 22/01/19.
//  Copyright © 2019 Clayton Oliveira. All rights reserved.
//

import UIKit

class LancamentoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var valorLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func Preparecell(lancamento: LancamentosModel){
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "R$ "
        formatter.alwaysShowsDecimalSeparator = true
        
        if let descricao = lancamento.deshisto {
            descricaoLabel.text = descricao
        }
        
        if let data = lancamento.datalancto {
            dataLabel.text = data
        }
        
        if let valor = lancamento.valorcontabil {
            let receitaValor = formatter.string(for: valor)!
            valorLabel.text = "\(receitaValor)"
        }
    }
}
