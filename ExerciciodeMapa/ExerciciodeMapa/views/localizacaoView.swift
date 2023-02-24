//
//  localizacaoView.swift
//  ExerciciodeMapa
//
//  Created by Ngori Januario on 21/02/23.
//

import SwiftUI
import MapKit

struct localizacaoView: View {
    
    @EnvironmentObject private var vm: localizacaoViewModel
    let maxWidthForIPad: CGFloat = 700
    
    var body: some View {
        ZStack{
            mapaLayer
                .ignoresSafeArea()
            VStack (spacing: 0) {
                cabecalho
                    .padding()
                    .frame(maxWidth: maxWidthForIPad)
                Spacer()
                localizacaoPreviewStatick
            }
        }
        .sheet(item: $vm.sheetLocation,onDismiss: nil){ localizacao in
            detalhesDosLocais(localizacao: localizacao)
        }
    }
}

struct localizacaoView_Previews: PreviewProvider {
    static var previews: some View {
        localizacaoView()
            .environmentObject(localizacaoViewModel())
    }
}

extension localizacaoView{
    
    private var cabecalho: some View{
        VStack {
            Button(action: vm.togglelistadeLocais){
                Text (vm.mapaLocalizacao.name + ", " + vm.mapaLocalizacao.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor (.primary)
                    .frame (height: 55)
                    .frame (maxWidth: .infinity)
                //Tirando a animacao
                    .animation(.none, value: vm.mapaLocalizacao)
                    .overlay(alignment: .leading){
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.abrirlista ? 180 : 0))
                    }
            }
            
            
            if vm.abrirlista{
                listadelocais()
            }
            
        }
        .background (.thickMaterial)
        .cornerRadius (10)
        .shadow (color: Color.black.opacity (0.3), radius: 20,y: 15)
    }
    
    private var mapaLayer: some View{
        Map(coordinateRegion: $vm.mapaRegiao,
            annotationItems: vm.locations,
            annotationContent: {localizacao in
            MapAnnotation(coordinate: localizacao.coordinates){
                anotacaoDaLocalizacao()
                    .scaleEffect(vm.mapaLocalizacao == localizacao ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.abripriximoLocal(localizacao: localizacao)
                    }
            }
        })
        
    }
    
    private var localizacaoPreviewStatick: some View {
        ZStack {
            ForEach(vm.locations){localizacao in
                if vm.mapaLocalizacao == localizacao{
                    LocalDePrevisao(localizacao: localizacao)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIPad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
                
            }
        }
    }
}
