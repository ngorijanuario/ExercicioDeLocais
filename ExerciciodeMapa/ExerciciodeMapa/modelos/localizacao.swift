//
//  localizacao.swift
//  ExerciciodeMapa
//
//  Created by Ngori Januario on 21/02/23.
//

import Foundation
import MapKit

struct localizacao: Identifiable, Equatable {
    //Criando variaveis
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D //Tipo de variavel de coordenadas do MapKit
    let description: String
    let imageNames: [String]
    let link: String
    
    var id: String{
        name + cityName
    }
    
    // Equatable
    static func == (lhs: localizacao, rhs: localizacao) -> Bool {
        lhs.id == rhs.id
    }
}
