//
//  SettingsViewController.swift
//  TipCalc
//
//  Created by Pooja Chowdhary on 2/7/17.
//  Copyright © 2017 Pooja Chowdhary. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var defaultTipOptions = [10, 15, 20]
    var honeydew = UIColor.init(red: 0.94, green: 1, blue: 0.94, alpha: 1)

    @IBOutlet weak var literalDefaultTipLabel: UILabel!
    @IBOutlet weak var literalDarkThemeLabel: UILabel!
    @IBOutlet weak var darkTheme: UISwitch!
    @IBAction func themeChanged(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(darkTheme.isOn, forKey: "isDarkTheme")
        defaults.synchronize()
        checkStoredTheme(fromViewWillAppear: false)
    }
    @IBOutlet weak var defaultTipSegment: UISegmentedControl!
    
    @IBAction func defaultTipSelected(_ sender: Any) {
    
        switch defaultTipSegment.selectedSegmentIndex {
        case 0:
            setDefaultTip(defaultTip: defaultTipOptions[0])
        case 1:
            setDefaultTip(defaultTip: defaultTipOptions[1])
        case 2:
            setDefaultTip(defaultTip: defaultTipOptions[2])
        default:
            setDefaultTip(defaultTip: defaultTipOptions[1])
            print("Invalid tip selected!")
        }
    }
    
    func setDefaultTip (defaultTip: Int) {
        let defaults = UserDefaults.standard
        defaults.set(defaultTip, forKey: "defaultTip")
        defaults.synchronize()
    }
    
    func setTheme(viewColor: UIColor, textColor: UIColor) {
        self.view.backgroundColor = viewColor
        literalDefaultTipLabel.textColor = textColor
        literalDarkThemeLabel.textColor = textColor
        defaultTipSegment.tintColor = textColor
        darkTheme.onTintColor = textColor
    }
    
    //Set theme as per stored value
    func checkStoredTheme(fromViewWillAppear: Bool) {
        if UserDefaults.standard.value(forKey: "isDarkTheme") != nil {
            if let storedTheme = UserDefaults.standard.value(forKey: "isDarkTheme") as! Bool? {
                darkTheme.isOn = storedTheme
                if storedTheme {
                    setTheme(viewColor: UIColor.black, textColor: honeydew)
                }
                else {
                    setTheme(viewColor: UIColor.white, textColor: UIColor.darkGray)
                }
            }
            else {
                setTheme(viewColor: UIColor.white, textColor: UIColor.darkGray)
                darkTheme.isOn = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        navigationItem.title = "Settings"

        checkStoredTheme(fromViewWillAppear: true)
        
        //Check default tip
        if UserDefaults.standard.value(forKey: "defaultTip") != nil {
            if let storedDefaultTip = UserDefaults.standard.value(forKey: "defaultTip") as! Int?{
                switch storedDefaultTip {
                case defaultTipOptions[0]:
                    defaultTipSegment.selectedSegmentIndex = 0
                case defaultTipOptions[1]:
                    defaultTipSegment.selectedSegmentIndex = 1
                case defaultTipOptions[2]:
                    defaultTipSegment.selectedSegmentIndex = 2
                default:
                    print("Stored default tip is invalid Int!")
                    defaultTipSegment.selectedSegmentIndex = 1
                    setDefaultTip(defaultTip: defaultTipOptions[1])
                }
            }
            else {
                print("Stored default tip is invalid!")
            }
        }
        else {
            print("Stored default tip does not exist!")
            defaultTipSegment.selectedSegmentIndex = 1
            setDefaultTip(defaultTip: defaultTipOptions[1])
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
