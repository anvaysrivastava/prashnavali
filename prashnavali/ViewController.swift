//
//  ViewController.swift
//  prashnavali
//
//  Created by Anvay Srivastava on 26/05/19.
//  Copyright © 2019 Anvay Srivastava. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    

    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let foods = ["1","2","3","4","5","6","7"]
    var rotation: CGFloat = CGFloat(-90 * (Double.pi/180))
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return foods.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textLabel.text = foods[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: textLabel.frame.width, height: textLabel.frame.height))
        label.text = foods[row]
        label.transform = CGAffineTransform(rotationAngle: -1*rotation)
        return label
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Setup horizontal pickerView
        let frame = pickerView.frame
    
        pickerView.transform = CGAffineTransform(rotationAngle: rotation)
        pickerView.frame = frame
        
        //Fetch data
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

