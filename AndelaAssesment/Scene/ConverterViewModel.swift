//
//  ConverterViewModel.swift
//  AndelaAssesment
//
//  Created by Syed Matloob on 06/12/2022.
//

import Foundation

class ConverterViewModel {
    
    var reloadDataSet: (() -> Void)?
    var reloadResult: (() -> Void)?
    private var latestResult = 0.0
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
                self?.currenceCells = allCurenciesModel
            
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func convert(from: String, to: String, amount: Double) {
        corruncyInteractor.FetchRemoteData(for: Convert.self, type: .getConversion(amount: amount, to: to, from: from)) { [weak self] result in
            switch result {
            case let .success(convert):
                print(convert)
                self?.latestResult = convert.result ?? 0.0
                self?.reloadResult?()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfCells() -> Int {
        return currenceCells.count
    }
    
    func getCellTitle(row: Int) -> String {
        // we can use safe indexing here as well but due to lack of time I am not implementing ! sorry :)
        return "\(currenceCells[row].symbol) : \(currenceCells[row].name)"
    }
    
    func getCellCode(row: Int) -> String {
        return "\(currenceCells[row].symbol)"
    }
    
    func fetchLatestResult() -> Double {
        return latestResult
    }
    
}
