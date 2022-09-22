//
//  Heroes.swift
//  ParcialUno
//
//  Created by Universidad Anahuac on 21/09/22.
//

import Foundation

struct Heroes: Codable {
    let response, id, name: String
    let image: Image
}

struct Image: Codable {
    let url: String
}
