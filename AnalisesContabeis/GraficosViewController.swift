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
    
    @IBOutlet weak var lblEmrpesa: UILabel!
    @IBOutlet weak var lblCnpj: UILabel!
    
    
    var months: [String]!
    
    var ListaPlanos: [ResultadoMensalModel] = []
    var label = UILabel()
    var EmpresaCod: String = ""
    var Competencia: String = ""
    var Conta: String = ""
    var Empresa = EmpresasModel()
    
    var Receitas: [ResultadoMensalModel] = []
    var Despesas: [ResultadoMensalModel] = []
    
    var ReceitasSem: [ResultadoMensalModel] = []
    var DespesasSem: [ResultadoMensalModel] = []
    
    var ReceitasBim: [ResultadoMensalModel] = []
    var DespesasBim: [ResultadoMensalModel] = []
    
    var ReceitasTri: [ResultadoMensalModel] = []
    var DespesasTri: [ResultadoMensalModel] = []
    
    var ReceitasQuadri: [ResultadoMensalModel] = []
    var DespesasQuadri: [ResultadoMensalModel] = []
    
    @IBAction func sgGraficoChanged(_ sender: Any) {
        
        self.navigationController!.navigationBar.barTintColor  = UIColor(named: "main")
        
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
            DataManager.receitasEmpresasTrimestre(empresa: EmpresaCod, exercicio: "2018", onComplete: {(planos) in
                DispatchQueue.main.async {
                    
                    self.ReceitasTri = planos
                    self.LoadChartTri()
                    self.lblGrafico.text = "Visualização por Trimestre"
                    
                }
            },onError: {(erro) in
                DispatchQueue.main.async {
                }
                
            })
        }
        else if sgGrafico.selectedSegmentIndex == 3 {
            DataManager.receitasEmpresasTrimestre(empresa: EmpresaCod, exercicio: "2018", onComplete: {(planos) in
                DispatchQueue.main.async {
                    
                    self.ReceitasQuadri = planos
                    self.LoadChartQuadri()
                    self.lblGrafico.text = "Visualização por Quadrimestre"
                    
                }
            },onError: {(erro) in
                DispatchQueue.main.async {
                }
                
            })
        }
        else if sgGrafico.selectedSegmentIndex == 4 {
            DataManager.receitasEmpresasTrimestre(empresa: EmpresaCod, exercicio: "2018", onComplete: {(planos) in
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
        pieMensal.delegate = self
        lblExercicio.text = Competencia
        
        if let razao = Empresa.razao {
            lblEmrpesa.text = razao
        }
        
        if let cnpj = Empresa.cnpj {
            lblCnpj.text = cnpj
        }
        
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
        
        months = ["Jan.", "Fev.", "Mar.", "Abr.", "Mai.", "Jun.", "Jul.", "Ago.", "Set.", "Out.", "Nov.", "Dez."]
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
        charDataSet.colors = ChartColorTemplates.joyful()//colors
        
        pieMensal.data = chartData
        pieMensal.animate(xAxisDuration: 1, yAxisDuration: 1, easingOption: .easeOutQuart)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "R$ "
        formatter.alwaysShowsDecimalSeparator = true
        
        pieMensal.data?.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        pieMensal.data?.setValueFont(NSUIFont.boldSystemFont(ofSize: 9))
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
        charDataSet.colors = ChartColorTemplates.joyful()//colors
        
        pieMensal.data = chartData
        pieMensal.animate(xAxisDuration: 1, yAxisDuration: 1, easingOption: .easeOutQuart)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "R$ "
        formatter.alwaysShowsDecimalSeparator = true
        
        pieMensal.data?.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        pieMensal.data?.setValueFont(NSUIFont.boldSystemFont(ofSize: 9))
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
        charDataSet.colors = ChartColorTemplates.joyful()//colors
        //pieMensal.formatt
        pieMensal.data = chartData
        pieMensal.animate(xAxisDuration: 1, yAxisDuration: 1, easingOption: .easeOutQuart)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "R$ "
        formatter.alwaysShowsDecimalSeparator = true
        
        pieMensal.data?.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        pieMensal.data?.setValueFont(NSUIFont.boldSystemFont(ofSize: 9))
        
    }
    func LoadChartTri() {
        months = ["1º Tri.", "2º Tri.", "3º Tri.", "4º Tri."]
        var totalDataEntry = [PieChartDataEntry]()
        var colors = [UIColor]()
        for i in 0..<months.count
        {
            let randomRed = Double.random(in: 1..<255)
            let randomGreen = Double.random(in: 1..<255)
            let randomBlue = Double.random(in: 1..<255)
            
            
            let receitasDataEntry = PieChartDataEntry(value: ReceitasTri[i].totalReceita!, label: "R$")
            receitasDataEntry.label = months[i]
            totalDataEntry.append(receitasDataEntry)
            let color = NSUIColor(red: CGFloat(randomRed/255.0), green: CGFloat(randomGreen/255.0), blue: CGFloat(randomBlue/255.0), alpha: 1.0)
            colors.append(color)
        }
        
        let charDataSet = PieChartDataSet(values: totalDataEntry, label: "")
        let chartData = PieChartData(dataSet: charDataSet)
        
        //let colors = [UIColor(named: "main"), UIColor(named: "second")]
        charDataSet.colors = ChartColorTemplates.joyful()//colors
        //pieMensal.formatt
        pieMensal.data = chartData
        pieMensal.animate(xAxisDuration: 1, yAxisDuration: 1, easingOption: .easeOutQuart)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "R$ "
        formatter.alwaysShowsDecimalSeparator = true
        
        pieMensal.data?.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        pieMensal.data?.setValueFont(NSUIFont.boldSystemFont(ofSize: 9))
    }
    func LoadChartQuadri() {
        months = ["1º Quadri.", "2º Quadri.", "3º Quadri."]
        var totalDataEntry = [PieChartDataEntry]()
        var colors = [UIColor]()
        for i in 0..<months.count
        {
            let randomRed = Double.random(in: 1..<255)
            let randomGreen = Double.random(in: 1..<255)
            let randomBlue = Double.random(in: 1..<255)
            
            
            let receitasDataEntry = PieChartDataEntry(value: ReceitasQuadri[i].totalReceita!, label: "R$")
            receitasDataEntry.label = months[i]
            totalDataEntry.append(receitasDataEntry)
            let color = NSUIColor(red: CGFloat(randomRed/255.0), green: CGFloat(randomGreen/255.0), blue: CGFloat(randomBlue/255.0), alpha: 1.0)
            colors.append(color)
        }
        
        let charDataSet = PieChartDataSet(values: totalDataEntry, label: "")
        let chartData = PieChartData(dataSet: charDataSet)
        
        //let colors = [UIColor(named: "main"), UIColor(named: "second")]
        charDataSet.colors = ChartColorTemplates.joyful()//colors
        //pieMensal.formatt
        pieMensal.data = chartData
        pieMensal.animate(xAxisDuration: 1, yAxisDuration: 1, easingOption: .easeOutQuart)
 
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "R$ "
        formatter.alwaysShowsDecimalSeparator = true
        
        pieMensal.data?.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        pieMensal.data?.setValueFont(NSUIFont.boldSystemFont(ofSize: 9))
        //pieMensal.xAxis.valueFormatter = formatter as? IAxisValueFormatter
        
        //lineChartDataSet.valueFormatter = valuesNumberFormatter
        //lineChartDataSet.valueFont = lineChartDataSet.valueFont.withSize(chartFontPointSize)
    }

}

extension GraficosViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "resumo") as! ResumoViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    
}
