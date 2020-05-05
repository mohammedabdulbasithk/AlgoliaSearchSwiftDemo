//
//  AlgoliaConnector.swift
//  BPT Search
//
//  Created by Apple on 20/02/20.
//  Copyright © 2020 Agaze. All rights reserved.
//

import Foundation
import InstantSearchClient

class AlgoliaConnector {
    let client = Client(appID: "ALWE9FCFQB", apiKey: "692d85dcdb0bee1837126a9cea20a04c")
    var m_algoliaClient = Client(appID: "", apiKey: "")
    var index: Index?
    var searchResults = [Any]()
    
    func configureAlgoliaClient(algoliaAppId: String, algoliaApiKey: String){
        m_algoliaClient = Client(appID: algoliaAppId, apiKey: algoliaApiKey)
    }
    
    func configureAlgoliaIndex(indexName: String){
        index = client.index(withName: indexName)
    }
    
    func pushDataToAlgolia(dataToPush: [[String: Any]], indexName: String){
        // Load content file
//        let jsonURL = Bundle.main.url(forResource: "contacts", withExtension: "json")
//        let jsonData = try! Data(contentsOf: jsonURL!)
//        let dict = try! JSONSerialization.jsonObject(with: jsonData)

        let algoliaIndex = client.index(withName: indexName)
        algoliaIndex.addObjects(dataToPush)
        
    }
    func pushJsonDataToAlgolia(jsonFileName: String, indexName: String){
            let jsonURL = Bundle.main.url(forResource: "contacts", withExtension: "json")
            let jsonData = try! Data(contentsOf: jsonURL!)
            let dict = try! JSONSerialization.jsonObject(with: jsonData)

            let algoliaIndex = client.index(withName: indexName)
            algoliaIndex.addObjects(dict as! [[String : Any]])
            
    }
    func pushDataToAlgolia(dataToPush: [[String: Any]]){
        index!.addObjects(dataToPush)
    }
    func pushJsonDataToAlgolia(jsonFileName: String){
        let jsonURL = Bundle.main.url(forResource: jsonFileName, withExtension: "json")
        let jsonData = try! Data(contentsOf: jsonURL!)
        let dict = try! JSONSerialization.jsonObject(with: jsonData)
        index!.addObject(dict as! [String : Any])
    }
    
    func configureAlgoliSearchSettings(customSearchAttributes: [String]){
        let customRanking = ["topicname"]
        let settings = ["searchableAttributes": customRanking]
        index!.setSettings(settings, completionHandler: { (content, error) -> Void in
            if error != nil {
                print("Error when applying settings: \(error!)")
            }
        })
    }
    
    func searchInAlgolia(keyWord: String, completionHandler: @escaping ([String: Any]) -> Void){
        // Search for a first name
        index!.search(Query(query: keyWord), completionHandler: { (content, error) -> Void in
            if error == nil {
                completionHandler(content!)
            }
        })
    }
}
