//
//  EmpresasTableViewController.swift
//  AnalisesContabeis
//
//  Created by Clayton Oliveira on 09/12/18.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class EmpresasTableViewController: UITableViewController {

    
    @IBAction func atualizaButton(_ sender: UIBarButtonItem) {
        CodEmpresa = ""
        setLoadingScreen()
        LoadEmpresas()
    }
    
    var CodEmpresa = ""
    var ListaEmpresas: [EmpresasModel] = []
    var label = UILabel()
    let searchController = UISearchController(searchResultsController: nil)
    /// View which contains the loading text and the spinner
    let loadingView = UIView()
    
    /// Spinner shown during load the TableView
    let spinner = UIActivityIndicatorView()
    
    /// Text shown during load the TableView
    let loadingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        
        navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
        
        label.text = "Informe o Nome ou Cödigo da Empresa"
        label.textAlignment = .center
        label.textColor = UIColor(named: "main")
        self.tableView.backgroundView = self.label
        setLoadingScreen()
        
        LoadEmpresas()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func LoadEmpresas() {
        
        if CodEmpresa == "" {
            DataManager.loadEmpresas(onComplete: {(empresas) in
                self.ListaEmpresas = empresas
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.removeLoadingScreen()
                    
                    if self.ListaEmpresas.count == 0 {
                        self.tableView.backgroundView = self.label
                    }
                    else {
                        self.tableView.backgroundView = nil
                    }
                    
                }
                
            },onError: {(erro) in
                
                DispatchQueue.main.async {
                    
                    self.removeLoadingScreen()
                    self.label.text = "Erro carregando empresas..."
                    self.tableView.backgroundView = self.label
                }
                
                
            })
        }
        else
        {
            DataManager.loadEmpresas(prefix: CodEmpresa, onComplete: {(empresas) in
                self.ListaEmpresas = empresas
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.removeLoadingScreen()
                    
                    if self.ListaEmpresas.count == 0 {
                        self.tableView.backgroundView = self.label
                    }
                    else {
                        self.tableView.backgroundView = nil
                    }
                    
                }
                
            },onError: {(erro) in
                
                DispatchQueue.main.async {
                    
                    self.removeLoadingScreen()
                    self.label.text = "Erro carregando empresas..."
                    self.tableView.backgroundView = self.label
                }
                
                
            })
        }

    }
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
    // MARK: - Table view data source
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! RelatoriosViewController
        let empresa = ListaEmpresas[tableView.indexPathForSelectedRow!.row]
        
        vc.Empresa = empresa
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmpresasTableViewCell
        
        cell.PrepareCell(empresa: ListaEmpresas[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ListaEmpresas.count
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
extension EmpresasTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        CodEmpresa = searchBar.text!
        setLoadingScreen()
        //CurrentPage = 0
        //ListaPecas.removeAll()
        //DesricaoPeca = ""
        LoadEmpresas()
    }
    
}
