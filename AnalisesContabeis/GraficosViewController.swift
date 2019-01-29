//
//  GraficosViewController.swift
//  AnalisesContabeis
//
//  Created by Clayton Oliveira on 28/01/19.
//  Copyright © 2019 Clayton Oliveira. All rights reserved.
//

import UIKit
import Charts

class GraficosViewController: UIViewController {

    @IBOutlet weak var pieMensal: PieChartView!
    @IBOutlet weak var sgGrafico: UISegmentedControl!
    @IBOutlet weak var lblGrafico: UILabel!
    @IBOutlet weak var lblExercicio: UILabel!
    
    var months: [String]!
    
    var ListaPlanos: [ResultadoMensalModel] = []
    var label = UILabel()
    var EmpresaCod: String = ""
    var Competencia: String = ""
    var Conta: String = ""
    
    var Receitas: [ResultadoMensalModel] = []
    var Despesas: [ResultadoMensalModel] = []
    
    var ReceitasSem: [ResultadoMensalModel] = []
    var DespesasSem: [ResultadoMensalModel] = []
    
    var ReceitasBim: [ResultadoMensalModel] = []
    var DespesasBim: [ResultadoMensalModel] = []
    
    @IBAction func sgGraficoChanged(_ sender: Any) {
        
        
        if sgGrafico.selectedSegmentIndex == 0 {
            DataManager.receitasEmpresasMensal(empresa: EmpresaCod, exercicio: "2018", onComplete: {(planos) in
                DispatchQueue.main.async {
                    
                    self.Receitas = planos
                    self.LoadChart()
                    self.lblGrafico.text = "Visualização Mensal"
                    
                }
            },onError: {(erro) in
                DispatchQueue.main.async {
                }
                
            })
        }
        else if sgGrafico.selectedSegmentIndex == 1 {
            DataManager.receitasEmpresasBimestre(empresa: EmpresaCod, exercicio: "2018", onComplete: {(planos) in
                DispatchQueue.main.async {
                    
                    self.ReceitasBim = planos
                    self.LoadChartBim()
                    self.lblGrafico.text = "Visualização por Bimestre"
                }
            },onError: {(erro) in
                DispatchQueue.main.async {
                }
                
            })
        }
        else if sgGrafico.selectedSegmentIndex == 2 {
            DataManager.receitasEmpresasSemestre(empresa: EmpresaCod, exercicio: "2018", onComplete: {(planos) in
                DispatchQueue.main.async {
                    
                    self.ReceitasSem = planos
                    self.LoadChartSem()
                    self.lblGrafico.text = "Visualização por Semestre"
                    
                }
            },onError: {(erro) in
                DispatchQueue.main.async {
                }
                
            })
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        lblExercicio.text = Competencia
        DataManager.receitasEmpresasMensal(empresa: EmpresaCod, exercicio: "2018", onComplete: {(planos) in
            DispatchQueue.main.async {
                
                self.Receitas = planos
                self.LoadChart()
                
            }
        },onError: {(erro) in
            DispatchQueue.main.async {
            }
            
        })
    }
    
    
    func LoadChart() {
        
        months = ["Jan.", "Fev.", "Mar.", "Mai.", "Abr.", "Jun.", "Jul.", "Ago.", "Set.", "Out.", "Nov.", "Dez."]
        var totalDataEntry = [PieChartDataEntry]()
        var colors = [UIColor]()
        for i in 0..<months.count
        {
            let randomRed = Double.random(in: 1..<255)
            let randomGreen = Double.random(in: 1..<255)
            let randomBlue = Double.random(in: 1..<255)
            
            
            let receitasDataEntry = PieChartDataEntry(value: Receitas[i].totalReceita!)
            receitasDataEntry.label = months[i]
            totalDataEntry.append(receitasDataEntry)
            let color = NSUIColor(red: CGFloat(randomRed/255.0), green: CGFloat(randomGreen/255.0), blue: CGFloat(randomBlue/255.0), alpha: 1.0)
            colors.append(color)
        }
        
        let charDataSet = PieChartDataSet(values: totalDataEntry, label: "")
        let chartData = PieChartData(dataSet: charDataSet)
        
        //let colors = [UIColor(named: "main"), UIColor(named: "second")]
        charDataSet.colors = colors
        
        pieMensal.data = chartData
        pieMensal.animate(xAxisDuration: 1, yAxisDuration: 1, easingOption: .easeOutQuart)
        
    }
    
    func LoadChartSem()
    {
        months = ["1º Semestre", "2º Semestre"]
        var totalDataEntry = [PieChartDataEntry]()
        var colors = [UIColor]()
        for i in 0..<months.count
        {
            let randomRed = Double.random(in: 1..<255)
            let randomGreen = Double.random(in: 1..<255)
            let randomBlue = Double.random(in: 1..<255)
            
            
            let receitasDataEntry = PieChartDataEntry(value: ReceitasSem[i].totalReceita!)
            receitasDataEntry.label = months[i]
            totalDataEntry.append(receitasDataEntry)
            let color = NSUIColor(red: CGFloat(randomRed/255.0), green: CGFloat(randomGreen/255.0), blue: CGFloat(randomBlue/255.0), alpha: 1.0)
            colors.append(color)
        }
        
        let charDataSet = PieChartDataSet(values: totalDataEntry, label: "")
        let chartData = PieChartData(dataSet: charDataSet)
        
        //let colors = [UIColor(named: "main"), UIColor(named: "second")]
        charDataSet.colors = colors
        
        pieMensal.data = chartData
        pieMensal.animate(xAxisDuration: 1, yAxisDuration: 1, easingOption: .easeOutQuart)
    }
    func LoadChartBim()
    {
        months = ["1º Bim.", "2º Bim.", "3º Bim.", "4º Bim.", "5º Bim.", "6º Bim."]
        var totalDataEntry = [PieChartDataEntry]()
        var colors = [UIColor]()
        for i in 0..<months.count
        {
            let randomRed = Double.random(in: 1..<255)
            let randomGreen = Double.random(in: 1..<255)
            let randomBlue = Double.random(in: 1..<255)
            
            
            let receitasDataEntry = PieChartDataEntry(value: ReceitasBim[i].totalReceita!, label: "R$")
            receitasDataEntry.label = months[i]
            totalDataEntry.append(receitasDataEntry)
            let color = NSUIColor(red: CGFloat(randomRed/255.0), green: CGFloat(randomGreen/255.0), blue: CGFloat(randomBlue/255.0), alpha: 1.0)
            colors.append(color)
        }
        
        let charDataSet = PieChartDataSet(values: totalDataEntry, label: "")
        let chartData = PieChartData(dataSet: charDataSet)
        
        //let colors = [UIColor(named: "main"), UIColor(named: "second")]
        charDataSet.colors = colors
        //pieMensal.formatt
        pieMensal.data = chartData
        pieMensal.animate(xAxisDuration: 1, yAxisDuration: 1, easingOption: .easeOutQuart)
        
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
