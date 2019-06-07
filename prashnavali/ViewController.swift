//
//  ViewController.swift
//  prashnavali
//
//  Created by Anvay Srivastava on 26/05/19.
//  Copyright © 2019 Anvay Srivastava. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pickedCharLabel: UILabel!
    @IBOutlet weak var shlokaDescription: UILabel!
    @IBOutlet weak var shloka1: UILabel!
    @IBOutlet weak var shloka2: UILabel!
    @IBOutlet weak var conclusionDescription: UILabel!
    @IBOutlet weak var conclusionLabel: UILabel!
    
    var tableCharacters: Array<AnyObject>!
    var shlokas: AnyObject!
    var rotation: CGFloat = CGFloat(-90 * (Double.pi/180))
    var isRotationOn = false
    var pickerNumber = 1
    var timer : Timer = Timer()
    //Properties for Start button
    @IBAction func startButtonPressed(_ sender: Any) {
        if(isRotationOn){
            isRotationOn = false
            startButton.setTitle("शुरूवात करें।", for: UIControl.State.normal)
            timer.invalidate()
            displayAkshar()
            displayShloka(shlokaId: tableCharacters[ pickerNumber % tableCharacters.count]["shlokaId"] as! String)
        } else {
            isRotationOn = true
            startButton.setTitle("निर्णय दिखाएँ।", for: UIControl.State.normal)
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(movePicker), userInfo: nil, repeats: true)
        }
    }
    
    func displayShloka(shlokaId: String){
        let shloka = shlokas![shlokaId] as AnyObject
        let phal = shloka["fhal"] as! String
        let shlokaArray = shloka["shloka"] as! Array<String>
        
        shloka1.text = shlokaArray[0]
        shloka1.isHidden = false
        shloka2.text = shlokaArray[1]
        shloka2.isHidden = false
        
        shlokaDescription.isHidden = false
        
        conclusionDescription.isHidden = false;
        conclusionLabel.text = phal
        conclusionLabel.isHidden = false;
        
    
    }
    
    func displayAkshar(){
        let first: String = tableCharacters[ pickerNumber % tableCharacters.count]["key"] as! String
        var followupKeys: Array<String> = tableCharacters[ pickerNumber % tableCharacters.count]["followupKeys"] as! Array<String>
        pickedCharLabel.text = String(format: "आपके अक्षर हैं %@ %@ %@ ", first, followupKeys[0], followupKeys[1])
        pickedCharLabel.isHidden = false
    }
    
    @objc public func movePicker(){
        pickerNumber = pickerNumber + Int.random(in: 0 ..< 10)
        _ = tableCharacters[pickerNumber % tableCharacters.count]["key"] as! String
        pickerView.selectRow(pickerNumber, inComponent: 0, animated: true)
    }
    
    // Properties for scroll
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Int(INT16_MAX)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
        label.text = tableCharacters[row % tableCharacters.count]["key"] as? String
        label.textAlignment = NSTextAlignment.center
        label.transform = CGAffineTransform(rotationAngle: -1*rotation)
        return label
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Init logic
        pickedCharLabel.isHidden = true
        shlokaDescription.isHidden = true
        shloka1.isHidden = true
        shloka2.isHidden = true
        conclusionDescription.isHidden = true
        conclusionLabel.isHidden = true
        
        // Setup horizontal pickerView
        let frame = pickerView.frame
        
        pickerView.transform = CGAffineTransform(rotationAngle: rotation)
        pickerView.frame = frame
        
        //Fetch data
        if let path = Bundle.main.path(forResource: "table", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Array<AnyObject> {
                    // do stuff
                    tableCharacters = jsonResult
                }
            } catch {
                // handle error
            }
        }
        
        if let path = Bundle.main.path(forResource: "shloka", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                shlokas = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as AnyObject
                
            } catch {
                // handle error
            }
        }
    }
}

