//
//  PhotosViewModel.swift
//  iOSQuiz
//
//  Created by 陳博竣 on 2020/11/9.
//

import Foundation

class PhotosViewModel {
    var items = [Photos]()
    
    func fetchPhotos(completion:@escaping () -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { fatalError() }
        let params = RestfulApiParameters(url, method: .get)
        
        RestfulApiManager.shared.requestApiData(params) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let photos = try decoder.decode([Photos].self, from: data)
                    self.items = photos
                    completion()
                } catch {
                    fatalError("Could not decode the response.")
                }
                
            case .failure(let error):
                fatalError(error.description)
            }
        }
    }
}
