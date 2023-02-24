//
//  detalhesDosLocais.swift
//  ExerciciodeMapa
//
//  Created by Ngori Januario on 23/02/23.
//

import SwiftUI
import MapKit

struct detalhesDosLocais: View {
    
    @EnvironmentObject private var vm: localizacaoViewModel
    let localizacao: localizacao
    
    var body: some View {
        ScrollView{
            VStack {
                seccaoDaImagem
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x : 0, y : 10)
                
                VStack(alignment: .leading, spacing: 16){
                    seccaoDoTitulo
                    Divider()
                    seccaoDaDescricao
                    Divider()
                    mapaLayer
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThickMaterial)
        .overlay(botaodevoltar, alignment: .topLeading)
    }
}

struct detalhesDosLocais_Previews: PreviewProvider {
    static var previews: some View {
        detalhesDosLocais(localizacao: LocationsDataService.locations.first!)
            .environmentObject(localizacaoViewModel())
    }
}

extension detalhesDosLocais{
    private var seccaoDaImagem: some View{
        TabView{
            ForEach(localizacao.imageNames, id: \.self){
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil :
                            UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var seccaoDoTitulo: some View{
        VStack(alignment: .leading, spacing: 8){
            Text(localizacao.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(localizacao.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var seccaoDaDescricao: some View{
        VStack(alignment: .leading, spacing: 16){
            Text(localizacao.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let url = URL(string: localizacao.link){
                Link("Read more in Wikipedia", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
    }
    
    private var mapaLayer: some View{
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: localizacao.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
            annotationItems: [localizacao]){ localizacao in
            MapAnnotation(coordinate: localizacao.coordinates){
                anotacaoDaLocalizacao()
                    .shadow(radius: 10)
            }
        }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)
    }
    
    private var botaodevoltar: some View{
        Button{
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
    
}
