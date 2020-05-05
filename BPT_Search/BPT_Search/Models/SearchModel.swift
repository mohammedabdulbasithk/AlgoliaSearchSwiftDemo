//
//  SearchModel.swift
//  BPT Search
//
//  Created by Apple on 20/02/20.
//  Copyright © 2020 Agaze. All rights reserved.
//

import Foundation

// search model
class Search {
    // code
    var searchResults = [""]
    var M_SEARCH_INDEX = "ventcast_Test"
    let searchServerObj = AlgoliaConnector()
    
    func configureSearchClientIndex(){
        searchServerObj.configureAlgoliaIndex(indexName: M_SEARCH_INDEX)
    }
    func configureSearchClientIndex(indexname: String){
        searchServerObj.configureAlgoliaIndex(indexName: indexname)
    }
    func configureSearchClient(){
        searchServerObj.configureAlgoliaClient(algoliaAppId: "ALWE9FCFQB", algoliaApiKey: "692d85dcdb0bee1837126a9cea20a04c")
    }
    func pushDataToSearchServer(dataForPush: [[String: Any]]){
        searchServerObj.pushDataToAlgolia(dataToPush: dataForPush, indexName: "ventcast_Test")
    }
    
    func getSearchResults(searchKeyWord: String, callBack: @escaping ([String]) -> Void){
        searchServerObj.searchInAlgolia(keyWord: searchKeyWord) { (searchResult) in
            if searchResult.isEmpty{
                self.searchResults = []
            }else{
                self.searchResults.removeAll()
                let array = searchResult["hits"] as! NSArray
                if array.count > 0{
                    for object in array{
                        let dictionary = object as! NSDictionary
                        if dictionary["topic_name"] != nil{
                            let topicname = dictionary["topic_name"] as! String
                            self.searchResults.append(topicname)
                        }else{
                            // nothing to do ...
                        }
                    }
                }else{
                    self.searchResults.append("No matching topic name found")
                }
                callBack(self.searchResults)
            }
        }
    }
}
