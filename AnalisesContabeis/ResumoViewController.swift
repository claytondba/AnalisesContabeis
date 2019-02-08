//
//  ResumoViewController.swift
//  AnalisesContabeis
//
//  Created by Clayton Oliveira on 31/01/19.
//  Copyright © 2019 Clayton Oliveira. All rights reserved.
//

import UIKit
import Charts

class ResumoViewController: UIViewController {

    @IBOutlet weak var fecharButton: UIButton!
    @IBOutlet weak var principalStack: UIStackView!
    @IBOutlet weak var pieChartGeral: PieChartView!
    
    var ListaPlanos: [PlanosModel] = []
    var EmpresaCod: String = ""
    var Competencia: String = ""
    var Conta: String = ""
    var TipoRelatorio: Int = 0
    var Periodo: String = ""
    var StringTotal: String = ""
    
    
    @IBOutlet weak var periodoLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBAction func ButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        periodoLabel.text = Periodo
        totalLabel.text = StringTotal
        
        //Mes
        
        //Bimestres
        if Periodo == "1º Bim." {
            Periodo = "1bimestre"
        }
        else if Periodo == "2º Bim." {
            Periodo = "2bimestre"
        }
        else if Periodo == "3º Bim." {
            Periodo = "3bimestre"
        }
        else if Periodo == "4º Bim." {
            Periodo = "4bimestre"
        }
        else if Periodo == "5º Bim." {
            Periodo = "5bimestre"
        }
        else if Periodo == "6º Bim." {
            Periodo = "6bimestre"
        }
        
        //Trimestre
        else if Periodo == "1º Tri." {
            Periodo = "1trimestre"
        }
        else if Periodo == "2º Tri." {
            Periodo = "2trimestre"
        }
        else if Periodo == "3º Tri." {
            Periodo = "3trimestre"
        }
        else if Periodo == "4º Tri." {
            Periodo = "4trimestre"
        }
        
        //Quadrimestres
        if Periodo == "1º Quadri." {
            Periodo = "1quadrimestre"
        }
        else if Periodo == "2º Quadri." {
            Periodo = "2quadrimestre"
        }
        else if Periodo == "3º Quadri." {
            Periodo = "3quadrimestre"
        }
        
        //Semestres
        else if Periodo == "1º Semestre" {
            Periodo = "1semestre"
        }
        else if Periodo == "2º Semestre" {
            Periodo = "2semestre"
        }
        
        
        if Conta == "" && TipoRelatorio == 0 {
            Conta = "31101"
        }
        else if Conta == "" && TipoRelatorio == 1 {
            Conta = "41101"
        }
        
        //Periodo = "1bimestre"
        if Periodo == "ano" {
            periodoLabel.text = "Anual (2018)"
            DataManager.loadPlanos(empresa: EmpresaCod, contaBase: Conta, exercicio: "2018", onComplete: { (planos) in
                DispatchQueue.main.async {
                self.ListaPlanos = planos
                self.LoadChartBim()
                }
            }) { (erro) in
                
            }
        }
        else {
            DataManager.receitasEmpresasPeriodo(empresa: EmpresaCod, exercicio: "2018", conta: Conta, periodo: Periodo, onComplete: {(planos) in
                DispatchQueue.main.async {
                    self.ListaPlanos = planos
                    self.LoadChartBim()
                }
            },onError: {(erro) in
                DispatchQueue.main.async {
                }
                
            })
        }
        
        
        
        /*
        let labelRes = UILabel()
        labelRes.translatesAutoresizingMaskIntoConstraints = false
        labelRes.textColor = UIColor(named: "main")
        labelRes.font = UIFont(name: "System Bold", size: 20)
   
 */
    }
    func LoadChartBim()
    {
        //months = ["1º Bim.", "2º Bim.", "3º Bim.", "4º Bim.", "5º Bim.", "6º Bim."]
        var totalDataEntry = [PieChartDataEntry]()
        var total: Double = 0
        for i in 0..<ListaPlanos.count
        {
            let receitasDataEntry = PieChartDataEntry(value: ListaPlanos[i].valor!, label: "R$")
            receitasDataEntry.label = ListaPlanos[i].descricao!
            totalDataEntry.append(receitasDataEntry)
            
            total += ListaPlanos[i].valor!
        }
        
        let charDataSet = PieChartDataSet(values: totalDataEntry, label: "")
        let chartData = PieChartData(dataSet: charDataSet)
        
        //let colors = [UIColor(named: "main"), UIColor(named: "second")]
        charDataSet.colors = ChartColorTemplates.material()//colors
        //pieMensal.formatt
        pieChartGeral.data = chartData
        pieChartGeral.animate(xAxisDuration: 1, yAxisDuration: 1, easingOption: .easeOutQuart)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "R$ "
        formatter.alwaysShowsDecimalSeparator = true
        
        pieChartGeral.data?.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        pieChartGeral.data?.setValueFont(NSUIFont.boldSystemFont(ofSize: 12))
        
    
        let receitaValor = formatter.string(for: total)!
        
        totalLabel.text = "\(receitaValor)"
    }
    
    /*
    func MontaLista() {
        for plan in ListaPlanos {
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.usesGroupingSeparator = true
            formatter.currencySymbol = "R$ "
            formatter.alwaysShowsDecimalSeparator = true
            
            let labelRes = UILabel()
            labelRes.translatesAutoresizingMaskIntoConstraints = false
            labelRes.textColor = UIColor(named: "main")
            labelRes.font = UIFont(name: "System", size: 20)
            labelRes.lineBreakMode = .byCharWrapping
            labelRes.numberOfLines = 2;
            if let valor = plan.valor {
                let receitaValor = formatter.string(for: valor)!
                labelRes.text = "\(plan.descricao!): \n\(receitaValor)"
            }
            
            
            
            principalStack.addArrangedSubview(labelRes)
        }
    }
    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
