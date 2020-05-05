//
//  ViewController.swift
//  BPT_Search
//
//  Created by Apple on 20/02/20.
//  Copyright © 2020 Agaze. All rights reserved.
//

import UIKit
import SearchTextField

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: SearchTextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearch()
        theAppModel.sharedInstance.searchObject.configureSearchClient()
        theAppModel.sharedInstance.searchObject.configureSearchClientIndex()
        textField.addTarget(self, action: #selector(search), for: .editingChanged)
        textField.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            print("Item at position \(itemPosition): \(item.title)")

            // Do whatever you want with the picked item
            self.textField.text = item.title
        }
    }
    @objc func search(){
        theAppModel.sharedInstance.searchObject.getSearchResults(searchKeyWord: textField.text!) { (searchResult) in
            self.textField.filterStrings(searchResult)
        }
    }
    func setupSearch(){
        
        textField.filterStrings(theAppModel.sharedInstance.searchObject.searchResults)
        textField.maxNumberOfResults = 3
        textField.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            // Do whatever you want with the picked item
            self.textField.text = item.title
        }
    }
}

