//
//  LocalDePrevisao.swift
//  ExerciciodeMapa
//
//  Created by Ngori Januario on 22/02/23.
//

import SwiftUI

struct LocalDePrevisao: View {
    
    @EnvironmentObject private var vm: localizacaoViewModel
    let localizacao: localizacao
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                seccaoDaImagem
                seccaoDoTitulo
            }
            VStack(spacing: 8){
                lermais
                proximo
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
    }
}

struct LocalDePrevisao_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            LocalDePrevisao(localizacao: LocationsDataService.locations.first!)
                .padding()
        }
        .environmentObject(localizacaoViewModel())
    }
}

extension LocalDePrevisao{
    
    private var seccaoDaImagem: some View{
        ZStack{
            if let imageName = localizacao.imageNames.first{
                Image(imageName)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
        
    }
    
    private var seccaoDoTitulo: some View{
        VStack(alignment: .leading, spacing: 4) {
            Text(localizacao.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(localizacao.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var lermais: some View{
        Button{
            vm.sheetLocation = localizacao
        }label: {
            Text("Ler mais")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var proximo: some View{
        Button{
            vm.proximoBotaoPrecionado()
        }label: {
            Text("Proximo")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}
