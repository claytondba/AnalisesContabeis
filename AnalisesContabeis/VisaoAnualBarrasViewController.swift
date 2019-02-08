//
//  VisaoAnualBarrasViewController.swift
//  AnalisesContabeis
//
//  Created by Clayton Oliveira on 04/02/19.
//  Copyright © 2019 Clayton Oliveira. All rights reserved.
//

import UIKit
import Charts

class VisaoAnualBarrasViewController: UIViewController {

    @IBOutlet weak var lineChartAnual: LineChartView!
    
    var months: [String]!
    
        
        var Receitas: [ResultadoMensalModel] = []
        var Despesas: [ResultadoMensalModel] = []
        var EmpresaCod: String = ""
        
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
    override func viewDidLoad() {
            super.viewDidLoad()
            
            DataManager.despesasEmpresasMensal(empresa: EmpresaCod, exercicio: "2018", onComplete: {(planos) in
                DispatchQueue.main.async {
                    self.Despesas = planos
                    DataManager.receitasEmpresasMensal(empresa: self.EmpresaCod, exercicio: "2018", onComplete: {(planos) in
                        DispatchQueue.main.async {
                            self.Receitas = planos
                            self.setChart()
                        }
                    },onError: {(erro) in
                        DispatchQueue.main.async {
                        }
                        
                    })
                }
            },onError: {(erro) in
                DispatchQueue.main.async {
                }
                
            })
            
            
            months = ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"]
            lineChartAnual.noDataText = "Sem informação necessária para contruir o Gráfico!."
            //barrasChart.chartDescription?.text = "sales vs bought "
            
            
        // Do any additional setup after loading the view.
    }
    
    func setChart()
    {
        //let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0]
        
        let test = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        
        var dataEntries: [ChartDataEntry] = []
        var dataEntries2: [ChartDataEntry] = []
        
        for i in 0..<months.count
        {
            let dataEntry = ChartDataEntry(x: Double(test[i]), y: Double(Receitas[i].totalReceita!))
            dataEntries.append(dataEntry)
            
            let dataEntry2 = ChartDataEntry(x: Double(test[i]), y: Double(Despesas[i].totalDespesa!))
            dataEntries2.append(dataEntry2)
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "R$ "
        formatter.alwaysShowsDecimalSeparator = true
        lineChartAnual.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "Receitas")
        chartDataSet.colors = [NSUIColor(red: 140.0/255.0, green: 234.0/255.0, blue: 255.0/255.0, alpha: 1.0)]
        let chartDataSet2 = LineChartDataSet(values: dataEntries2, label: "Despesas")
        chartDataSet2.colors = [NSUIColor(red: 255/255.0, green: 105/255.0, blue: 180/255.0, alpha: 1.0)]
        
        chartDataSet.valueFormatter = formatter as? IValueFormatter
        chartDataSet2.valueFormatter = formatter as? IValueFormatter
        
        let chartData = LineChartData(dataSet: chartDataSet)
        chartData.addDataSet(chartDataSet2)
        
        lineChartAnual.notifyDataSetChanged()
        
        lineChartAnual.data = chartData
        
        lineChartAnual.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
        
    }
    


}
