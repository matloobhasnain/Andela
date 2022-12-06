//
//  ConverterViewModel.swift
//  AndelaAssesment
//
//  Created by Syed Matloob on 06/12/2022.
//

import Foundation

class ConverterViewModel {
    
    var reloadDataSet: (() -> Void)?
    private var corruncyInteractor: CorruncyInteractor
    private var currenceCells = [CurrencyCellModel]() {
        didSet {
            reloadDataSet?()
        }
    }
    
    init(interactor: CorruncyInteractor = CorruncyInteractor()) {
        self.corruncyInteractor = interactor
    }
    
    func load() {
        corruncyInteractor.FetchRemoteData(for: Currency.self, type: .fetchAllCurrencies) { [weak self] result in
            switch result {
            case let .success(currency):
         
                guard let allCurrencies = currency.symbols else { return }
                var allCurenciesModel = [CurrencyCellModel]()
                let keysArray = [String] (allCurrencies.keys)
                for key in keysArray {
                    let keyDescription = allCurrencies[key]
                    allCurenciesModel.append(CurrencyCellModel(symbol: key, name: keyDescription ?? ""))
                }
                print(self?.currenceCells.count)
                self?.currenceCells = allCurenciesModel
                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
