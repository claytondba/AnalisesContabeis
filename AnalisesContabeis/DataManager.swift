//
//  DataManager.swift
//  AnalisesContabeis
//
//  Created by Clayton Oliveira on 09/12/18.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import Foundation

enum ErrorManager: String {
    case CredentialError = "Credenciais incorretas"
    case NetworkError = "Rede de dados com problemas"
    case TimeOut = "Tempo de resposta do servidor"
    case JSONConvert = "Erro lendo os dados recebidos"
    case Not200 = "Status diferente de 200"
    case Exception = "Erro desconhecido..."
}

class DataManager {
    
    //public static var UserToken: String = Configuration.shared.TokenAPI
   // private static let basePath = "http://server.candinho.com.br/rob/api/"
    private static var basePath = Configuration.shared.TokenAPI
    //private static let basePath = "https://candinhoapp.azurewebsites.net/api/"
    static var LastURL = ""
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true;
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 60.0
        config.httpMaximumConnectionsPerHost = 90
        config.shouldUseExtendedBackgroundIdleMode = true
        
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    class func loadPlanos(empresa: String, contaBase: String, exercicio: String, tipo: String, onComplete: @escaping ([PlanosModel]) -> Void, onError: @escaping (Bool) -> Void){
        
        LastURL = basePath + "receitas/\(empresa)/\(contaBase)/\(exercicio)/tipo/\(tipo)"
        guard let url = URL(string: basePath + "receitas/\(empresa)/\(contaBase)/\(exercicio)/tipo/\(tipo)") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([PlanosModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    
    class func loadPlanos(prefix: String, onComplete: @escaping ([PlanosModel]) -> Void, onError: @escaping (Bool) -> Void){
        
        guard let url = URL(string: basePath + "receitas/\(prefix)") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([PlanosModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func loadPlanosDespesas(prefix: String, onComplete: @escaping ([PlanosModel]) -> Void, onError: @escaping (Bool) -> Void){
        
        guard let url = URL(string: basePath + "despesas/\(prefix)") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([PlanosModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func loadEmpresas(onComplete: @escaping ([EmpresasModel]) -> Void, onError: @escaping (Bool) -> Void){
        

        basePath = Configuration.shared.TokenAPI
        guard let url = URL(string: basePath + "empresas") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([EmpresasModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func receitasEmpresasMensal(empresa: String, exercicio: String, onComplete: @escaping ([ResultadoMensalModel]) -> Void, onError: @escaping (Bool) -> Void){
        LastURL = basePath + "empresas/\(empresa)/\(exercicio)/receitas"
        guard let url = URL(string: basePath + "empresas/\(empresa)/\(exercicio)/receitas") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([ResultadoMensalModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func receitasEmpresasGeralAno(empresa: String, exercicio: String, onComplete: @escaping ([ResultadoMensalModel]) -> Void, onError: @escaping (Bool) -> Void){
        LastURL = basePath + "empresas/\(empresa)/\(exercicio)/receitas"
        guard let url = URL(string: basePath + "empresas/\(empresa)/\(exercicio)/receitas") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([ResultadoMensalModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func receitasEmpresasTrimestre(empresa: String, exercicio: String, onComplete: @escaping ([ResultadoMensalModel]) -> Void, onError: @escaping (Bool) -> Void){
        LastURL = basePath + "empresas/\(empresa)/\(exercicio)/receitas/trimestre"
        guard let url = URL(string: basePath + "empresas/\(empresa)/\(exercicio)/receitas/trimestre") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([ResultadoMensalModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func despesasEmpresasAnualContas(empresa: String, exercicio: String, onComplete: @escaping ([PlanosModel]) -> Void, onError: @escaping (Bool) -> Void){
        LastURL = basePath + "despesas/\(empresa)/\(exercicio)/despesa"
        guard let url = URL(string: basePath + "despesas/\(empresa)/\(exercicio)/despesa") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([PlanosModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func receitasEmpresasAnualContas(empresa: String, exercicio: String, onComplete: @escaping ([PlanosModel]) -> Void, onError: @escaping (Bool) -> Void){
        LastURL = basePath + "receitas/\(empresa)/\(exercicio)/receita"
        guard let url = URL(string: basePath + "receitas/\(empresa)/\(exercicio)/receita") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([PlanosModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func receitasEmpresasPeriodo(empresa: String, exercicio: String, conta: String, periodo: String, onComplete: @escaping ([PlanosModel]) -> Void, onError: @escaping (Bool) -> Void){
        LastURL = basePath + "receitas/\(empresa)/\(conta)/periodo/\(periodo)"
        guard let url = URL(string: basePath + "receitas/\(empresa)/\(conta)/periodo/\(periodo)") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([PlanosModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func receitasEmpresasQuadrimestre(empresa: String, exercicio: String, onComplete: @escaping ([ResultadoMensalModel]) -> Void, onError: @escaping (Bool) -> Void){
        LastURL = basePath + "empresas/\(empresa)/\(exercicio)/receitas/quadrimestre"
        guard let url = URL(string: basePath + "empresas/\(empresa)/\(exercicio)/receitas/quadrimestre") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([ResultadoMensalModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func receitasEmpresasSemestre(empresa: String, exercicio: String, onComplete: @escaping ([ResultadoMensalModel]) -> Void, onError: @escaping (Bool) -> Void){
        LastURL = basePath + "empresas/\(empresa)/\(exercicio)/receitas/semestre"
        guard let url = URL(string: basePath + "empresas/\(empresa)/\(exercicio)/receitas/semestre") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([ResultadoMensalModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func receitasEmpresasBimestre(empresa: String, exercicio: String, onComplete: @escaping ([ResultadoMensalModel]) -> Void, onError: @escaping (Bool) -> Void){
        LastURL = basePath + "empresas/\(empresa)/\(exercicio)/receitas/bimestre"
        guard let url = URL(string: basePath + "empresas/\(empresa)/\(exercicio)/receitas/bimestre") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([ResultadoMensalModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    
    //------------------
    
    class func despesasEmpresasTrimestre(empresa: String, exercicio: String, onComplete: @escaping ([ResultadoMensalModel]) -> Void, onError: @escaping (Bool) -> Void){
        LastURL = basePath + "empresas/\(empresa)/\(exercicio)/despesas/trimestre"
        guard let url = URL(string: basePath + "empresas/\(empresa)/\(exercicio)/despesas/trimestre") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([ResultadoMensalModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    
    class func despesasEmpresasQuadrimestre(empresa: String, exercicio: String, onComplete: @escaping ([ResultadoMensalModel]) -> Void, onError: @escaping (Bool) -> Void){
        LastURL = basePath + "empresas/\(empresa)/\(exercicio)/despesas/quadrimestre"
        guard let url = URL(string: basePath + "empresas/\(empresa)/\(exercicio)/despesas/quadrimestre") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([ResultadoMensalModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func despesasEmpresasSemestre(empresa: String, exercicio: String, onComplete: @escaping ([ResultadoMensalModel]) -> Void, onError: @escaping (Bool) -> Void){
        LastURL = basePath + "empresas/\(empresa)/\(exercicio)/despesas/semestre"
        guard let url = URL(string: basePath + "empresas/\(empresa)/\(exercicio)/despesas/semestre") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([ResultadoMensalModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func despesasEmpresasBimestre(empresa: String, exercicio: String, onComplete: @escaping ([ResultadoMensalModel]) -> Void, onError: @escaping (Bool) -> Void){
        LastURL = basePath + "empresas/\(empresa)/\(exercicio)/despesas/bimestre"
        guard let url = URL(string: basePath + "empresas/\(empresa)/\(exercicio)/despesas/bimestre") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([ResultadoMensalModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    
    
    
    
    
    //-------
    class func despesasEmpresasMensal(empresa: String, exercicio: String, onComplete: @escaping ([ResultadoMensalModel]) -> Void, onError: @escaping (Bool) -> Void){
        LastURL = basePath + "empresas/\(empresa)/\(exercicio)/despesas"
        guard let url = URL(string: basePath + "empresas/\(empresa)/\(exercicio)/despesas") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([ResultadoMensalModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func resultadoEmpresa(empresa: String, exercicio: String, onComplete: @escaping ([ResultadosModel]) -> Void, onError: @escaping (Bool) -> Void){
        LastURL = basePath + "empresas/\(empresa)/\(exercicio)"
        guard let url = URL(string: basePath + "empresas/\(empresa)/\(exercicio)") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([ResultadosModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func loadLancamentos(empresa: String, competencia: String, conta: String, onComplete: @escaping ([LancamentosModel]) -> Void, onError: @escaping (Bool) -> Void){
        
        LastURL = basePath + "receitas/\(empresa)/\(competencia)/\(conta)"
        
        guard let url = URL(string: basePath + "receitas/\(empresa)/\(competencia)/\(conta)") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([LancamentosModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func loadEmpresas(prefix: String, onComplete: @escaping ([EmpresasModel]) -> Void, onError: @escaping (Bool) -> Void){
        
        guard let url = URL(string: basePath + "empresas/\(prefix)") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([EmpresasModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    
    class func loadConfig(empresa: String, onComplete: @escaping ([ConfigAnalisesModel]) -> Void, onError: @escaping (Bool) -> Void){
        
        guard let url = URL(string: basePath + "configanalises/\(empresa)") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([ConfigAnalisesModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    
    
    /* Metodos POST */
    
    
    class func saveConfig(cfg: ConfigAnalisesModel, onComplete: @escaping (Bool) -> Void) {
        
        LastURL = basePath + "configanalises/add"
        guard let url = URL(string: basePath + "configanalises/add") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let json = try? JSONEncoder().encode(cfg) else {
            return
        }
        
        request.httpBody = json
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let _ = data else {
                    onComplete(false)
                    return
                }
                
                onComplete(true)
                
            } else {
                onComplete(false)
                return
            }
        }
        
        dataTask.resume()
    }
    
    class func deleteConfig(cfg: ConfigAnalisesModel, onComplete: @escaping (Bool) -> Void) {
        
        LastURL = basePath + "configanalises/delete"
        guard let url = URL(string: basePath + "configanalises/delete") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        guard let json = try? JSONEncoder().encode(cfg) else {
            return
        }
        
        request.httpBody = json
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let _ = data else {
                    onComplete(false)
                    return
                }
                
                onComplete(true)
                
            } else {
                onComplete(false)
                return
            }
        }
        
        dataTask.resume()
    }
    
    /*
 
    class func loadPecaComplete(peca: String, onComplete: @escaping (Peca) -> Void, onError: @escaping (Bool) -> Void){
        
        guard let url = URL(string: basePath + "pecas/image/\(peca)") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {
                    onError(true)
                    return
                }
                
                if response.statusCode == 200
                {
                    
                    guard let data = data else {return}
                    //print(data)
                    do {
                        
                        let pec = try JSONDecoder().decode(Peca.self, from: data)
                        onComplete(pec)
                        
                        if pec.image == nil {
                            onError(true)
                        }
                        
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    
    class func loadPecas(prefix: String, onComplete: @escaping ([Peca]) -> Void, onError: @escaping (ErrorManager) -> Void){
        guard let url = URL(string: basePath + "pecas/" + prefix) else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {
                    onError(ErrorManager.NetworkError)
                    return
                }
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do {
                        let pecas = try JSONDecoder().decode([Peca].self, from: data)
                        onComplete(pecas)
                    }
                    catch
                    {
                        onError(ErrorManager.JSONConvert)
                        print(error.localizedDescription)
                    }
                }
                else {
                    print(response.statusCode)
                    onError(ErrorManager.Not200)
                    return
                }
                
            }
            else
            {
                onError(ErrorManager.Exception)
                print(error!.localizedDescription)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func loadPecasDescricao(descricao: String = "", page: Int = 0, onComplete: @escaping ([Peca]) -> Void){
        
        var baseUrl = ""
        
        if descricao == ""{
            baseUrl = basePath + "pecas/descricao/-/\(page)"
        }
        else
        {
            baseUrl = basePath + "pecas/descricao/\(descricao)/\(page)"
        }
        guard let url = URL(string: baseUrl) else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    
                    guard let data = data else {return}
                    print(data)
                    do {
                        let pecas = try JSONDecoder().decode([Peca].self, from: data)
                        onComplete(pecas)
                    }
                    catch
                    {
                        print(error.localizedDescription)
                    }
                }
                
            }
            else
            {
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    */
}
