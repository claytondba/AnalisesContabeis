//
//  PlanosTableViewController.swift
//  AnalisesContabeis
//
//  Created by Clayton Oliveira on 09/12/18.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class PlanosTableViewController: UITableViewController {

    
    
    @IBOutlet weak var nvItem: UINavigationItem!
    var ListaPlanos: [PlanosModel] = []
    var label = UILabel()
    var EmpresaCod: String = ""
    var TipoRelatorio = 0;
    /// View which contains the loading text and the spinner
    let loadingView = UIView()
    
    /// Spinner shown during load the TableView
    let spinner = UIActivityIndicatorView()
    
    /// Text shown during load the TableView
    let loadingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if TipoRelatorio == 1 {
            nvItem.title = "Despesas"
        }
        
        label.text = "Nenhum resultado encontrado!"
        label.textAlignment = .center
        label.textColor = UIColor(named: "main")
        
        setLoadingScreen()
        
        LoadPlanos()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func LoadPlanos() {
        
        if EmpresaCod == "" {
            EmpresaCod = "000000"
        }
        if TipoRelatorio == 0 {
            DataManager.loadPlanos(prefix: EmpresaCod, onComplete: {(planos) in
                self.ListaPlanos = planos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.removeLoadingScreen()
                    
                    if self.ListaPlanos.count == 0 {
                        self.tableView.backgroundView = self.label
                    }
                    else {
                        self.tableView.backgroundView = nil
                    }
                    
                }
                
            },onError: {(erro) in
                
                DispatchQueue.main.async {
                    
                    self.removeLoadingScreen()
                    self.label.text = "Erro carregando receitas..."
                    self.tableView.backgroundView = self.label
                }
                
                
            })
        }
        else if TipoRelatorio == 1 {
            DataManager.loadPlanosDespesas(prefix: EmpresaCod, onComplete: {(planos) in
                self.ListaPlanos = planos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.removeLoadingScreen()
                    
                    if self.ListaPlanos.count == 0 {
                        self.tableView.backgroundView = self.label
                    }
                    else {
                        self.tableView.backgroundView = nil
                    }
                    
                }
                
            },onError: {(erro) in
                
                DispatchQueue.main.async {
                    
                    self.removeLoadingScreen()
                    self.label.text = "Erro carregando despesas..."
                    self.tableView.backgroundView = self.label
                }
                
                
            })
        }
    }
    // MARK: - Table view data source
    private func removeLoadingScreen() {
        
        // Hides and stops the text and the spinner
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
        
    }
    // Set the activity indicator into the main view
    private func setLoadingScreen() {
        
        spinner.style = .whiteLarge
        spinner.color = UIColor(named: "main")
        spinner.startAnimating()
        tableView.backgroundView = spinner
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlanosTableViewCell
        
        cell.Preparecell(plano: ListaPlanos[indexPath.row])
        //cell.PrepareCell(empresa: ListaEmpresas[indexPath.row])
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ListaPlanos.count
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! LancamentosTableViewController
        
        vc.EmpresaCod = self.EmpresaCod
        vc.Competencia = "2018"
        vc.Conta = ListaPlanos[tableView.indexPathForSelectedRow!.row].conta!

    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
