//
//  VisaoAnualViewController.swift
//  AnalisesContabeis
//
//  Created by Clayton Oliveira on 23/01/19.
//  Copyright © 2019 Clayton Oliveira. All rights reserved.
//

import UIKit
import Charts

class VisaoAnualViewController: UIViewController {

    @IBOutlet weak var chartBarAnual: BarChartView!

    
    var months: [String]!
    
    var Receitas: [ResultadoMensalModel] = []
    var Despesas: [ResultadoMensalModel] = []
    var EmpresaCod: String = ""
    
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
        
        
        chartBarAnual.noDataText = "Sem informação necessária para contruir o Gráfico!."
        //barrasChart.chartDescription?.text = "sales vs bought "
        
        
        //legend
        let legend = chartBarAnual.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;
        
        
        let xaxis = chartBarAnual.xAxis
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottom
        xaxis.centerAxisLabelsEnabled = true
        xaxis.valueFormatter = IndexAxisValueFormatter(values:self.months)
        xaxis.granularity = 1
        
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1
        
        let yaxis = chartBarAnual.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        
        chartBarAnual.rightAxis.enabled = false
        //axisFormatDelegate = self
        
       
    }
    
    func setChart()
    {
        //let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0]
        
        let test = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries2: [BarChartDataEntry] = []
        
        for i in 0..<months.count
        {
            let dataEntry = BarChartDataEntry(x: Double(test[i]), y: Double(Receitas[i].totalReceita!))
            dataEntries.append(dataEntry)
            
            let dataEntry2 = BarChartDataEntry(x: Double(test[i]), y: Double(Despesas[i].totalDespesa!))
            dataEntries2.append(dataEntry2)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Receitas")
        chartDataSet.colors = [NSUIColor(red: 140.0/255.0, green: 234.0/255.0, blue: 255.0/255.0, alpha: 1.0)]
        let chartDataSet2 = BarChartDataSet(values: dataEntries2, label: "Despesas")
        chartDataSet2.colors = [NSUIColor(red: 255/255.0, green: 105/255.0, blue: 180/255.0, alpha: 1.0)]
        
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.addDataSet(chartDataSet2)
        
        //let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3
        let groupSpace = 0.3
        // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"
        
        let groupCount = self.months.count
        let startYear = 0
        
        
        chartData.barWidth = barWidth;
        chartBarAnual.xAxis.axisMinimum = Double(startYear)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        print("Groupspace: \(gg)")
        chartBarAnual.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)
        
        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        //chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        chartBarAnual.notifyDataSetChanged()
        
        chartBarAnual.data = chartData
        
        
        //background color
        //barrasChart.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        
        //chart animation
        chartBarAnual.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
        
    }
    
    @IBAction func closButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
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
