//
//  ViewController.swift
//  TipCalc
//
//  Created by Pooja Chowdhary on 2/6/17.
//  Copyright © 2017 Pooja Chowdhary. All rights reserved.
//

import UIKit

class TipCalcViewController: UIViewController {

    var amount: TipCalc!
    var honeydew = UIColor.init(red: 0.94, green: 1, blue: 0.94, alpha: 1)
    
    @IBOutlet weak var literalBillAmountLabel: UILabel!
    @IBOutlet weak var literalTipPercentLabel: UILabel!
    @IBOutlet weak var literalTotalAmountLabel: UILabel!
    @IBOutlet weak var literalNoOfPersonsLabel: UILabel!
    @IBOutlet weak var literalSplitAmountLabel: UILabel!
    @IBOutlet weak var billAmountText: UITextField!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var noOfPersonsLabel: UILabel!
    @IBOutlet weak var splitAmountLabel: UILabel!
    @IBOutlet weak var increaseTipButtonLabel: UIButton!
    @IBOutlet weak var decreaseTipButtonLabel: UIButton!
    @IBOutlet weak var increasePersonsButtonLabel: UIButton!
    @IBOutlet weak var decreasePersonsButtonLabel: UIButton!
    
    @IBAction func billAmountLblChanged(_ sender: Any) {
        if billAmountText.text == "" {
            amount.billAmount = 0.0
        }
        else {
            amount.billAmount = Double(billAmountText.text!)!
        }
        amount.updateCalculation()
        display()
    }
    
    @IBAction func increaseTipButton(_ sender: Any) {
        var tip = Int(tipPercentLabel.text!)!
        if tip < 100 {
            tip += 1
            amount.tipPercent = tip
            amount.updateCalculation()
            display()
        }
    }

    @IBAction func decreaseTipButton(_ sender: Any) {
        var tip = Int(tipPercentLabel.text!)!
        if tip > 0 {
            tip -= 1
            amount.tipPercent = tip
            amount.updateCalculation()
            display()
        }
    }
    
    @IBAction func increasePersonsButton(_ sender: Any) {
        var split = Int(noOfPersonsLabel.text!)!
        if split < 100 {
            split += 1
            amount.splitPersons = split
            amount.updateCalculation()
            display()
        }
    }
    
    @IBAction func decreasePersonsButton(_ sender: Any) {
        var split = Int(noOfPersonsLabel.text!)!
        if split > 1 {
            split -= 1
            amount.splitPersons = split
            amount.updateCalculation()
            display()
        }
    }
    
    func display() {
        tipPercentLabel.text = String(amount.tipPercent)
        noOfPersonsLabel.text = String(amount.splitPersons)
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        currencyFormatter.locale = Locale.current

        var amountString = currencyFormatter.string(for: amount.totalAmount)
        totalAmountLabel.text = amountString
        amountString = currencyFormatter.string(for: amount.splitAmount)
        splitAmountLabel.text = amountString
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check timestamp when the application was exited inorder to retain bill amount
        let date1 = Date()
        let date2 = UserDefaults.standard.value(forKey: "exitDate")
        var billAmount = 0.0
        if date2 != nil {
            let interval = date1.timeIntervalSince(date2 as! Date)
            print(interval)
            if interval < 300 {
                if let storedAmount = UserDefaults.standard.value(forKey: "billAmount") as! Double? {
                    billAmount = storedAmount
                    billAmountText.text = String(billAmount)
                }
            }
        }
        amount = TipCalc(bill: billAmount, tip: 10, split: 1)
    
        //Gesture Recognizer for long press
        let increaseTipLongPress = UILongPressGestureRecognizer(target: self, action: #selector(TipCalcViewController.increaseTipButton(_:)))
        increaseTipButtonLabel.addGestureRecognizer(increaseTipLongPress)
        increaseTipButtonLabel.layer.cornerRadius = increaseTipButtonLabel.frame.size.width / 2
        increaseTipButtonLabel.backgroundColor = honeydew
        
        let decreaseTipLongPress = UILongPressGestureRecognizer(target: self, action: #selector(TipCalcViewController.decreaseTipButton(_:)))
        decreaseTipButtonLabel.addGestureRecognizer(decreaseTipLongPress)
        decreaseTipButtonLabel.layer.cornerRadius = decreaseTipButtonLabel.frame.size.width / 2
        decreaseTipButtonLabel.backgroundColor = honeydew

        let increasePersonsLongPress = UILongPressGestureRecognizer(target: self, action: #selector(TipCalcViewController.increasePersonsButton(_:)))
        increasePersonsButtonLabel.addGestureRecognizer(increasePersonsLongPress)
        increasePersonsButtonLabel.layer.cornerRadius = increasePersonsButtonLabel.frame.size.width / 2
        increasePersonsButtonLabel.backgroundColor = honeydew
        
        let decreasePersonsLongPress = UILongPressGestureRecognizer(target: self, action: #selector(TipCalcViewController.decreasePersonsButton(_:)))
        decreasePersonsButtonLabel.addGestureRecognizer(decreasePersonsLongPress)
        decreasePersonsButtonLabel.layer.cornerRadius = decreasePersonsButtonLabel.frame.size.width / 2
        decreasePersonsButtonLabel.backgroundColor = honeydew
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func setTheme(viewColor: UIColor, textColor: UIColor) {
        self.view.backgroundColor = viewColor
        literalBillAmountLabel.textColor = textColor
        literalTipPercentLabel.textColor = textColor
        literalTotalAmountLabel.textColor = textColor
        literalNoOfPersonsLabel.textColor = textColor
        literalSplitAmountLabel.textColor = textColor
        billAmountText.textColor = textColor
        tipPercentLabel.textColor = textColor
        totalAmountLabel.textColor = textColor
        noOfPersonsLabel.textColor = textColor
        splitAmountLabel.textColor = textColor
    }
    
    func keyboardWillShow(notification: NSNotification) {
        literalNoOfPersonsLabel.isHidden = true
        literalSplitAmountLabel.isHidden = true
        increasePersonsButtonLabel.isHidden = true
        decreasePersonsButtonLabel.isHidden = true
        noOfPersonsLabel.isHidden = true
        splitAmountLabel.isHidden = true
    }
    
    func keyboardWillHide(notification: NSNotification) {
        literalNoOfPersonsLabel.isHidden = false
        literalSplitAmountLabel.isHidden = false
        increasePersonsButtonLabel.isHidden = false
        decreasePersonsButtonLabel.isHidden = false
        noOfPersonsLabel.isHidden = false
        splitAmountLabel.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        
         billAmountText.becomeFirstResponder()
        //Check for default tip
        if UserDefaults.standard.value(forKey: "defaultTip") != nil {
            if let storedDefaultTip = UserDefaults.standard.value(forKey: "defaultTip") as! Int? {
                amount.tipPercent = storedDefaultTip
                amount.updateCalculation()
                display()
            }
        }
        else {
            let defaults = UserDefaults.standard
            defaults.set(15, forKey: "defaultTip")
            defaults.synchronize()
            amount.updateCalculation()
            display()
        }
        
        if UserDefaults.standard.value(forKey: "isDarkTheme") != nil {
            if let storedTheme = UserDefaults.standard.value(forKey: "isDarkTheme") as! Bool? {
                if storedTheme {
                    setTheme(viewColor: UIColor.black, textColor: honeydew)
                }
                else {
                    setTheme(viewColor: UIColor.white, textColor: UIColor.darkGray)
                }
            }
            else {
                setTheme(viewColor: UIColor.black, textColor: honeydew)
                print("no default")
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(amount.billAmount, forKey: "billAmount")
        defaults.synchronize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

