//
//  ViewController.swift
//  prashnavali
//
//  Created by Anvay Srivastava on 26/05/19.
//  Copyright © 2019 Anvay Srivastava. All rights reserved.
//

import UIKit


class ViewController: UIViewController {


    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Array<AnyObject> {
                    // do stuff
                    let sholkas = jsonResult[0]["shloka"] as! Array<String>
                    textLabel.text = sholkas[0]
                    
                }
            } catch {
                // handle error
            }
        }
    }
}

