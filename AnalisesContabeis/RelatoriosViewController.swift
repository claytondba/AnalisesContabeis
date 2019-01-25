//
//  RelatoriosViewController.swift
//  AnalisesContabeis
//
//  Created by Clayton Oliveira on 11/12/18.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit
import Charts

class RelatoriosViewController: UIViewController {

    var Empresa: EmpresasModel = EmpresasModel()
    var Exercicio: Int = 2018

  
    @IBOutlet weak var exercicioLabel: UILabel!
    @IBOutlet weak var pieChartAnual: PieChartView!
    @IBOutlet weak var empresaLabel: UILabel!
    @IBOutlet weak var cnpjLabel: UILabel!
    @IBOutlet weak var responsavelLabel: UILabel!
    @IBOutlet weak var telefoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    //var months: [String]!
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        UIApplication.shared.open(URL(fileURLWithPath: "tel://12345678"))
    }
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        telefoneLabel.isUserInteractionEnabled = true
        telefoneLabel.addGestureRecognizer(tap)
        
        
        super.viewDidLoad()
        
        exercicioLabel.text = "\(Exercicio)"
        
        if let razao = Empresa.razao {
            empresaLabel.text = razao
        }
        if let resp = Empresa.nome_titular {
            responsavelLabel.text = "Responsável: \(resp)"
        }
        
        if let cnpj = Empresa.cnpj {
            cnpjLabel.text = "CNPJ: \(cnpj)"
        }
        
        if let ddd = Empresa.ddd {
            telefoneLabel.text = "Telefone: (\(ddd)) \(Empresa.telefone!)"
        }
        
        if let email = Empresa.email {
            emailLabel.text = "Email: \(email)"
        }
        
        pieChartAnual.noDataText = "..."
        
        DataManager.resultadoEmpresa(empresa: Empresa.codigo!, exercicio: "2018", onComplete: {(planos) in
            DispatchQueue.main.async {
                self.LoadChart(resultado: planos[0])
            }
        },onError: {(erro) in
            
            DispatchQueue.main.async {
                
            }

        })

    }
    
    func LoadChart(resultado: ResultadosModel) {
        
        
        let receitasDataEntry = PieChartDataEntry(value: resultado.receita!)
        receitasDataEntry.label = "Receitas"
        
        let despesasDataEntry = PieChartDataEntry(value: resultado.despesa!)
        despesasDataEntry.label = "Despesas"
        
        var totalDataEntry = [PieChartDataEntry]()
        totalDataEntry = [receitasDataEntry, despesasDataEntry]
        
        let charDataSet = PieChartDataSet(values: totalDataEntry, label: "-- Exercício: \(resultado.exercicio!)")
        let chartData = PieChartData(dataSet: charDataSet)
        
        let colors = [UIColor(named: "main"), UIColor(named: "second")]
        charDataSet.colors = colors as! [NSUIColor]
        
        pieChartAnual.data = chartData
        pieChartAnual.animate(xAxisDuration: 1, yAxisDuration: 1, easingOption: .easeOutQuart)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let empresa = Empresa.codigo!

        if segue.identifier == "sgRec"
        {
            let vc = segue.destination as! PlanosTableViewController
            vc.TipoRelatorio = 0
            vc.EmpresaCod = empresa

        }
        else if segue.identifier == "sgDesp"
        {
            let vc = segue.destination as! PlanosTableViewController
            vc.TipoRelatorio = 1
            vc.EmpresaCod = empresa
        }
        else if segue.identifier == "sgAnual"
        {
            let vc = segue.destination as! VisaoAnualViewController
            vc.EmpresaCod = empresa
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