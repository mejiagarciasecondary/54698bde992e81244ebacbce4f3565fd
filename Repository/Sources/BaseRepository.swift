//
//  BaseRepository.swift
//  
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import Foundation

public class BaseRepository {
    func getSerializedData<T: Decodable>(data: Data) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
