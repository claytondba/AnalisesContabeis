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
    var Competencia = "2018"
  
    @IBOutlet weak var exercicioLabel: UILabel!
    @IBOutlet weak var pieChartAnual: PieChartView!
    @IBOutlet weak var empresaLabel: UILabel!
    @IBOutlet weak var cnpjLabel: UILabel!
    @IBOutlet weak var responsavelLabel: UILabel!
    @IBOutlet weak var telefoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var percLabel: UILabel!
    
    
    //var months: [String]!
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        UIApplication.shared.open(URL(fileURLWithPath: "tel://12345678"))
    }
    override func viewDidLoad() {
        
      
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        telefoneLabel.isUserInteractionEnabled = true
        telefoneLabel.addGestureRecognizer(tap)
        self.navigationController!.navigationBar.barTintColor  = UIColor(named: "main")
        
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
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "R$ "
        formatter.alwaysShowsDecimalSeparator = true
        
        pieChartAnual.data?.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        pieChartAnual.data?.setValueFont(NSUIFont.boldSystemFont(ofSize: 9))
        
        if let res = resultado.receita, let des = resultado.despesa {
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .transitionCrossDissolve, animations: {
                self.percLabel.text =  String(format: "%.0f", Double((des / res) * 100)) + "%"
                if self.percLabel.text == "nan%" {
                    self.percLabel.text = "00%"
                }
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            
        }
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
        if segue.identifier == "sgLucro"
        {
            let vc = segue.destination as! GraficosViewController
            //c.TipoRelatorio = 0
            vc.EmpresaCod = empresa
            vc.Competencia = Competencia
            vc.Empresa = self.Empresa
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .transitionCrossDissolve, animations: {
            self.navigationController?.navigationBar.barTintColor = UIColor(named: "main")
            self.navigationController?.navigationBar.layoutIfNeeded()
        }, completion: nil)
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

