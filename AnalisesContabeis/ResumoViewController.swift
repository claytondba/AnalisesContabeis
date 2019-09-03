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

    @IBOutlet weak var tltLabel: UILabel!
    @IBOutlet weak var fecharButton: UIButton!
    @IBOutlet weak var principalStack: UIStackView!
    @IBOutlet weak var pieChartGeral: PieChartView!
    @IBOutlet weak var anoLabel: UILabel!
    @IBOutlet weak var rodapeView: UIView!
    @IBOutlet weak var pickerGrafico: UIPickerView!
    @IBOutlet weak var barChartAnual: BarChartView!
    
    var ListaPlanos: [PlanosModel] = []
    var EmpresaCod: String = ""
    var Competencia: String = ""
    var Conta: String = ""
    var TipoRelatorio: Int = 0
    var Periodo: String = ""
    var StringTotal: String = ""
    var BloqueiaNivel = false
    var pickerData: [String] = ["Pizza", "Barras"]
    
    //Carregamento
    var label = UILabel()
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    @IBOutlet weak var periodoLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBAction func ButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        //Configuracao do Loading
        label.text = "Nenhum resultado encontrado!"
        label.textAlignment = .center
        label.textColor = UIColor(named: "main")
        
        super.viewDidLoad()
        pieChartGeral.delegate = self
        pieChartGeral.noDataText = ""
        //pickerGrafico.setValue(color1, forKey: "textColor")
        pickerGrafico.reloadAllComponents()
        pickerGrafico.dataSource = self
        pickerGrafico.delegate = self
        
        loadChartAll()
    }
    
    func loadChartAll() {
        
        pieChartGeral.isHidden = false;
        barChartAnual.isHidden = true;
        
        if Conta == "" && TipoRelatorio == 0 {
            Conta = "31101"
            tltLabel.text = "Receitas por Período"
            rodapeView.tintColor = UIColor(named: "main")
        }
        else if Conta == "" && TipoRelatorio == 1 {
            tltLabel.text = "Despesas por Período"
            Conta = "41101"
            rodapeView.tintColor = UIColor(named: "second")
        }
            
        if Periodo == "ano"
        {
            if TipoRelatorio == 0 {
                tltLabel.text = "Receitas por Período"
            }
            else {
                tltLabel.text = "Despesas por Período"
            }
        }
        
        periodoLabel.text = Periodo
        totalLabel.text = StringTotal
        anoLabel.text = "2018"
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
        
        
        //Adaptacao para informar se é uma conta de receita ou despesa
        var tipo: String = ""
        
        if TipoRelatorio == 0 {
            tipo = "C"
        }
        else if TipoRelatorio == 1 {
            tipo = "D"
        }
        
        
        if Periodo == "ano" {
            periodoLabel.text = "Anual"
            setLoadingScreen()
            DataManager.loadPlanos(empresa: EmpresaCod, contaBase: Conta, exercicio: "2018", tipo: tipo, onComplete: { (planos) in
                DispatchQueue.main.async {
                    self.ListaPlanos = planos
                    self.LoadChartBim()
                    self.removeLoadingScreen()
                }
            }) { (erro) in
                
            }
        } //Aqui entra pela tela inicial do programa (Quando clica em Despesa ou Receita)
        else if Periodo == "receita"{
            periodoLabel.text = "Receitas"
            //ID:R001
            setLoadingScreen()
            DataManager.receitasEmpresasAnualContas(empresa: EmpresaCod, exercicio: "2018", onComplete: { (planos) in
                DispatchQueue.main.async {
                    self.ListaPlanos = planos
                    self.LoadChartBim()
                    self.removeLoadingScreen()
                }
            }) { (erro) in
                
            }
        }
        else if Periodo == "despesa" {
            periodoLabel.text = "Despesas"
            //ID:D001
            setLoadingScreen()
            DataManager.despesasEmpresasAnualContas(empresa: EmpresaCod, exercicio: "2018", onComplete: { (planos) in
                DispatchQueue.main.async {
                    self.ListaPlanos = planos
                    self.LoadChartBim()
                    self.removeLoadingScreen()
                }
            }) { (erro) in
                
            }
        }
        else {
            //ID:COO1
            setLoadingScreen()
            DataManager.receitasEmpresasPeriodo(empresa: EmpresaCod, exercicio: "2018", conta: Conta, periodo: Periodo, onComplete: {(planos) in
                DispatchQueue.main.async {
                    self.ListaPlanos = planos
                    self.LoadChartBim()
                    self.removeLoadingScreen()
                }
            },onError: {(erro) in
                DispatchQueue.main.async {
                }
                
            })
        }
        
    }
    func LoadCharBarras()
    {
        
        pieChartGeral.isHidden = true;
        barChartAnual.isHidden = false;
        
        
        let chartData = BarChartData()
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = ""
        formatter.alwaysShowsDecimalSeparator = true
        
        barChartAnual.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        
        for i in 0..<ListaPlanos.count
        {
            var dataEntries: [BarChartDataEntry] = []
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(ListaPlanos[i].valor!))
            dataEntries.append(dataEntry)
            
            let chartDataSet = BarChartDataSet(values: dataEntries, label: ListaPlanos[i].descricao)
            let red:CGFloat = CGFloat(drand48())
            let green:CGFloat = CGFloat(drand48())
            let blue:CGFloat = CGFloat(drand48())
            chartDataSet.colors = [UIColor(red:red, green: green, blue: blue, alpha: 1.0)]
            
            chartDataSet.valueFormatter = formatter as? IValueFormatter
            chartData.addDataSet(chartDataSet)
        }
        
        barChartAnual.xAxis.axisMinimum = Double(0)
        barChartAnual.notifyDataSetChanged()
        barChartAnual.data = chartData
        //chart animation
        barChartAnual.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
    }
    func LoadChartBim()
    {
        //months = ["1º Bim.", "2º Bim.", "3º Bim.", "4º Bim.", "5º Bim.", "6º Bim."]
        var totalDataEntry = [PieChartDataEntry]()
        var total: Double = 0
        for i in 0..<ListaPlanos.count
        {
            let receitasDataEntry = PieChartDataEntry(value: ListaPlanos[i].valor!, label: "")
            receitasDataEntry.label = ListaPlanos[i].descricao!
            receitasDataEntry.accessibilityHint = ListaPlanos[i].conta!
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
        formatter.currencySymbol = ""
        formatter.alwaysShowsDecimalSeparator = true
        
        pieChartGeral.data?.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        pieChartGeral.data?.setValueFont(NSUIFont.boldSystemFont(ofSize: 12))
        
    
        let receitaValor = formatter.string(for: total)!
        
        totalLabel.text = "\(receitaValor)"
    }
    
    // Remove the activity indicator from the main view
    private func removeLoadingScreen() {
        
        spinner.stopAnimating()
        spinner.isHidden = true
        label.isHidden = true
        
    }
    // Set the activity indicator into the main view
    private func setLoadingScreen() {
        
        spinner.style = .whiteLarge
        spinner.color = UIColor(named: "main")
        spinner.startAnimating()
    }
}
extension ResumoViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if !BloqueiaNivel {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "resumo") as! ResumoViewController
            
            let pCahde = entry as! PieChartDataEntry
            
            newViewController.EmpresaCod = self.EmpresaCod
            
            
            if TipoRelatorio == 0 {
                newViewController.Conta = pCahde.accessibilityHint!  //"31101"
                newViewController.Periodo = "ano"
                newViewController.TipoRelatorio = 0
                newViewController.BloqueiaNivel = true
            }
            else {
                newViewController.Conta = pCahde.accessibilityHint! //newViewController.Conta = "41101"
                newViewController.Periodo = "ano"
                newViewController.TipoRelatorio = 1
                newViewController.BloqueiaNivel = true
            }
            
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.usesGroupingSeparator = true
            formatter.currencySymbol = ""
            formatter.alwaysShowsDecimalSeparator = true
            newViewController.StringTotal = formatter.string(from: NSNumber(value: pCahde.value))!
            //newViewController.Conta = entry.description
            
            
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }
        
        //self.present(newViewController, animated: true, completion: nil)
    }
    
    
}
extension ResumoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerData[row] == "Pizza" {
            loadChartAll()
        }
        else if pickerData[row] == "Barras" {
            LoadCharBarras()
        }
    }
}

