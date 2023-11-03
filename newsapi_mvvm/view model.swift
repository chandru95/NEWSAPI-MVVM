//
//  view model.swift
//  newsapi_mvvm
//
//  Created by Karthiga on 10/13/23.
//

import Foundation
class ApiIntegration: Any{

   func getdate(urlString: String, oncompletion: @escaping (ArticleS) -> Void, onerror: @escaping (Error) -> Void){
        guard let url = URL(string: urlString) else {return}
            // Create a URLSession instance
        let task = URLSession.shared.dataTask(with: url){(data,response,error) in
//            guard error == nil else{return}
//            guard let httpResponse = response else {return}
            guard let datas = data else {return}
            
            do {
                let content = try?JSONDecoder().decode(ArticleS.self, from: datas)
                oncompletion(content!)
            }
            catch {
                onerror(error)
            }
        }
        task.resume()
    }
}
