//
//  Errors.swift
//
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import Foundation

extension Lang {
    public struct Errors {
        public static let title = "Error"
        public static let unexpectedError = "Unexpected error, please try again"
        public static let invalidUrl = "Unable to parse current url to an Apple URL"
        public static let unexpectedStatusCode = "Unexpected status code received: %d"
        public static let responseNoLegible = "Unable to validate received response, maybe it is corrupted"
        public static let unableToSerializeData = "Unable to serialize data provided by the service call"
    }
}
