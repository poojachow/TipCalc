//
//  TipCalc.swift
//  TipCalc
//
//  Created by Pooja Chowdhary on 2/7/17.
//  Copyright © 2017 Pooja Chowdhary. All rights reserved.
//

import Foundation

class TipCalc {
    private var _billAmount: Double
    private var _totalAmount: Double
    private var _splitAmount: Double
    private var _tipPercent: Int
    private var _splitPersons: Int
    
    var billAmount: Double {
        get {
            return _billAmount
        }
        set {
            _billAmount = newValue
        }
    }
    
    var totalAmount: Double {
        get {
            return _totalAmount
        }
        set {
            _totalAmount = newValue
        }
    }
    
    var splitAmount: Double {
        get {
            return _splitAmount
        }
        set {
            _splitAmount = newValue
        }
    }
    
    var tipPercent: Int {
        get {
            return _tipPercent
        }
        set {
            _tipPercent = newValue
        }
    }
    
    var splitPersons: Int {
        get {
            return _splitPersons
        }
        set {
            _splitPersons = newValue
        }
    }
    
    init(bill: Double, tip: Int, split: Int) {
        _billAmount = bill
        _tipPercent = tip
        _splitPersons = split
        _totalAmount = _billAmount
        _splitAmount = _billAmount
    }
    
    func updateCalculation() {
        _totalAmount = _billAmount + (_billAmount * (Double(_tipPercent) / 100.00))
        _splitAmount = _totalAmount / Double(_splitPersons)
    }
}
