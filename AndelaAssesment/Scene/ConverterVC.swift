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
    lazy var viewModel = {
        ConverterViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseViewModel()
    }
    
    private func initialiseViewModel() {
        viewModel.load()
        viewModel.reloadDataSet = { [weak self] in
            DispatchQueue.main.async {
                print("reload it")
            }
        }
    }
    
    @IBAction func convertCurrencyPressed(_ sender: UIButton) {
        
    }
    @IBAction func showDetailPressed(_ sender: Any) {
        
    }
}

