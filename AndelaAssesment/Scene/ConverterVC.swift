//
//  ViewController.swift
//  AndelaAssesment
//
//  Created by Syed Matloob on 06/12/2022.
//

import UIKit

class ConverterVC: UIViewController {
    
    @IBOutlet weak var fromHeadingText: UITextField!
    @IBOutlet weak var toHeadingText: UITextField!
    @IBOutlet weak var fromAmountText: UITextField!
    @IBOutlet weak var toAmountText: UITextField!
    @IBOutlet weak var currencyPicker: UIPickerView!
    private var activeTextField: UITextField?
    
    lazy var viewModel = {
        ConverterViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseViewModel()
        setupUI()
    }
    
    private func initialiseViewModel() {
        viewModel.load()
        viewModel.reloadDataSet = { [weak self] in
            DispatchQueue.main.async {
                self?.currencyPicker.reloadAllComponents()
                self?.activeTextField?.text = self?.viewModel.getCellCode(row: 0)
            }
        }
        
        viewModel.reloadResult = { [weak self] in
            DispatchQueue.main.async {
                self?.toAmountText.text = "\(self?.viewModel.fetchLatestResult() ?? 0)"
            }
        }
    }
    
    private func setupUI() {
        fromHeadingText.inputView = currencyPicker
        toHeadingText.inputView = currencyPicker
        fromHeadingText.becomeFirstResponder()
    }
    
    @IBAction func convertCurrencyPressed(_ sender: UIButton) {
        if let from = fromHeadingText.text, let to = toHeadingText.text, let amount = fromAmountText.text, !from.isEmpty && !to.isEmpty && !amount.isEmpty  {
            if let doubleAmount = Double(fromAmountText.text ?? "") {
               viewModel.convert(from: from, to: to, amount: doubleAmount)
            }
        }
    }
    
    @IBAction func showDetailPressed(_ sender: Any) {
        
    }
}


extension ConverterVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numberOfCells()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.getCellTitle(row: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeTextField?.text = viewModel.getCellCode(row: row)
    }
}

extension ConverterVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
}
