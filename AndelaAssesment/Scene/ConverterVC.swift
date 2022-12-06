//
//  ViewController.swift
//  AndelaAssesment
//
//  Created by Syed Matloob on 06/12/2022.
//

import UIKit

class ConverterVC: UIViewController {
    
    lazy var viewModel = {
        ConverterViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseViewModel()
    }
    
    private func initialiseViewModel() {
        viewModel.load()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                print("reload it")
            }
        }
    }
}

