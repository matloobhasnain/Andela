//
//  CorruncyInteractor.swift
//  AndelaAssesment
//
//  Created by Syed Matloob on 06/12/2022.
//

import Foundation


class CorruncyInteractor {
        
    func FetchRemoteData<T: Decodable>(for: T.Type = T.self,type: AppNetwork, completion: @escaping ((Result<T,Error>) -> Void))
    {
        appNetworkProvider.request(type) { [weak self](result) in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(T.self, from: data)
                  //
                   // print(responseModel)
                    completion(.success(responseModel))
                    
                }catch (let error) {
                    completion(.failure(error))
                }
                
            case let .failure(error):
                completion(.failure(error))
                break
                
            }
            
        }
    }
}
