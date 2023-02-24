//
//  localizacoesViewsModelos.swift
//  ExerciciodeMapa
//
//  Created by Ngori Januario on 21/02/23.
//

import Foundation
import MapKit
import SwiftUI

class localizacaoViewModel: ObservableObject{
    
    //Criação de uma matris de varios locais
    @Published var locations: [localizacao]
    //Localizacao do mapa
    @Published var mapaLocalizacao: localizacao{
        didSet{
            atualizacaodoMap(location: mapaLocalizacao)
        }
    }
    
    // Pegar a regiao do mapa
    @Published var mapaRegiao: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan (latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    //Abrir lista de locais
    @Published var abrirlista: Bool = false
    
    //Abrir as informacoes apartir da do sheet
    @Published var sheetLocation: localizacao? = nil
    
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapaLocalizacao = locations.first!
        self.atualizacaodoMap(location: locations.first!)
    }
    
    private func atualizacaodoMap(location: localizacao){
        withAnimation(.easeInOut) {
            mapaRegiao = MKCoordinateRegion (
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
    func togglelistadeLocais(){
        withAnimation(.easeInOut){
            abrirlista = !abrirlista
        }
    }
    
    func abripriximoLocal(localizacao: localizacao){
        withAnimation(.easeInOut){
            mapaLocalizacao = localizacao
            abrirlista = false
        }
    }
    
    func proximoBotaoPrecionado(){
        
        //pegar o index
        guard let correntIndex = locations.firstIndex(where: {$0 == mapaLocalizacao}) else {
            print("Ngori")
            return
        }
        
        //Validar o index
        let proximoIndex = correntIndex + 1
        guard locations.indices.contains(proximoIndex) else {
            //Proximo index nao é valido
            //Voltar para a posição 0
            guard let primeiraLocalizacao = locations.first else { return }
            abripriximoLocal(localizacao: primeiraLocalizacao)
            return
        }
        //Proximo localizacao for validada
        let proximaLocalizacao = locations[proximoIndex]
        abripriximoLocal(localizacao: proximaLocalizacao)
    }
}
