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
    
    private static let basePath = "https://candinhoapp.azurewebsites.net/api/"
    static var LastURL = ""
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true;
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 90
        config.shouldUseExtendedBackgroundIdleMode = true
        
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    class func loadPlanos(empresa: String, contaBase: String, exercicio: String, onComplete: @escaping ([PlanosModel]) -> Void, onError: @escaping (Bool) -> Void){
        
        LastURL = basePath + "receitas/\(empresa)/\(contaBase)"
        guard let url = URL(string: basePath + "receitas/\(empresa)/\(contaBase)") else {return}
        
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
    class func despesasEmpresasMensal(empresa: String, exercicio: String, onComplete: @escaping ([ResultadoMensalModel]) -> Void, onError: @escaping (Bool) -> Void){
        LastURL = basePath + "empresas/\(empresa)/\(exercicio)/depesas"
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
