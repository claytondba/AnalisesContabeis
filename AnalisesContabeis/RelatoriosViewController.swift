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
    var months: [String]!
    var Receitas: [ResultadoMensalModel] = []
    var Despesas: [ResultadoMensalModel] = []
    
    @IBOutlet weak var lineChartAnual: LineChartView!
    @IBOutlet weak var pieChartAnual: PieChartView!
    @IBOutlet weak var barChartAnual: BarChartView!
    
    @IBOutlet weak var exercicioLabel: UILabel!
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
    
    @IBAction func pieButton(_ sender: Any) {
        
        pieChartAnual.isHidden = false
        barChartAnual.isHidden = true
        lineChartAnual.isHidden = true
    }
    
    @IBAction func barGrButton(_ sender: Any) {
        
        pieChartAnual.isHidden = true
        barChartAnual.isHidden = false
        lineChartAnual.isHidden = true
        
        DataManager.despesasEmpresasMensal(empresa: self.Empresa.codigo!, exercicio: "2018", onComplete: {(planos) in
            DispatchQueue.main.async {
                self.Despesas = planos
                DataManager.receitasEmpresasMensal(empresa: self.Empresa.codigo!, exercicio: "2018", onComplete: {(planos) in
                    DispatchQueue.main.async {
                        self.Receitas = planos
                        self.setChartBarras()
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
    }
    @IBAction func lineGrButton(_ sender: Any) {
        
        pieChartAnual.isHidden = true
        lineChartAnual.isHidden = false
        barChartAnual.isHidden = true
        
        DataManager.despesasEmpresasMensal(empresa: Empresa.codigo!, exercicio: "2018", onComplete: {(planos) in
            DispatchQueue.main.async {
                self.Despesas = planos
                DataManager.receitasEmpresasMensal(empresa: self.Empresa.codigo!, exercicio: "2018", onComplete: {(planos) in
                    DispatchQueue.main.async {
                        self.Receitas = planos
                        self.setChartLine()
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
    }
    override func viewDidLoad() {
        
        pieChartAnual.delegate = self
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
        
        months = ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"]
        
        
        barChartAnual.noDataText = "Carregando..."
        //barrasChart.chartDescription?.text = "sales vs bought "
        
        
        //legend
        let legend = barChartAnual.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;
        
        
        let xaxis = barChartAnual.xAxis
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottom
        xaxis.centerAxisLabelsEnabled = true
        xaxis.valueFormatter = IndexAxisValueFormatter(values:self.months)
        xaxis.granularity = 1
        
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1
        
        let yaxis = barChartAnual.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        
        barChartAnual.rightAxis.enabled = false
        //axisFormatDelegate = self
        
        DataManager.resultadoEmpresa(empresa: Empresa.codigo!, exercicio: "2018", onComplete: {(planos) in
            DispatchQueue.main.async {
                self.LoadChart(resultado: planos[0])
            }
        },onError: {(erro) in
            
            DispatchQueue.main.async {
                
            }

        })

    }
    func setChartLine()
    {
        //let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0]
        
        let test = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        
        var dataEntries: [ChartDataEntry] = []
        var dataEntries2: [ChartDataEntry] = []
        
        for i in 0..<test.count
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
    func setChartBarras()
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
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "R$ "
        formatter.alwaysShowsDecimalSeparator = true
        barChartAnual.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Receitas")
        chartDataSet.colors = [NSUIColor(red: 140.0/255.0, green: 234.0/255.0, blue: 255.0/255.0, alpha: 1.0)]
        let chartDataSet2 = BarChartDataSet(values: dataEntries2, label: "Despesas")
        chartDataSet2.colors = [NSUIColor(red: 255/255.0, green: 105/255.0, blue: 180/255.0, alpha: 1.0)]
        
        chartDataSet.valueFormatter = formatter as? IValueFormatter
        chartDataSet2.valueFormatter = formatter as? IValueFormatter
        
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
        barChartAnual.xAxis.axisMinimum = Double(startYear)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        print("Groupspace: \(gg)")
        barChartAnual.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)
        
        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        //chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        barChartAnual.notifyDataSetChanged()
        
        barChartAnual.data = chartData
        
        
        //background color
        //barrasChart.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        
        //chart animation
        barChartAnual.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
        
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
        else if segue.identifier == "sgOpcoes"
        {
            let vc = segue.destination as! OpcoesViewController
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
        if segue.identifier == "sgDespesas"
        {
            let vc = segue.destination as! GraficosViewController
            vc.TipoRelatorio = 1
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

}

extension RelatoriosViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "resumo") as! ResumoViewController
        
        let pCahde = entry as! PieChartDataEntry
        
        newViewController.EmpresaCod = self.Empresa.codigo!
        newViewController.Periodo = "ano"
        
        if pCahde.label == "Receitas" {
            newViewController.Conta = "31101"
        }
        else {
            newViewController.Conta = "41101"
        }
        
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "R$ "
        formatter.alwaysShowsDecimalSeparator = true
        newViewController.StringTotal = formatter.string(from: NSNumber(value: pCahde.value))!
        //newViewController.Conta = entry.description
        
        
        self.navigationController?.pushViewController(newViewController, animated: true)
        
        //self.present(newViewController, animated: true, completion: nil)
    }
    
    
}


