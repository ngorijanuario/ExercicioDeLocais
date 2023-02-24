//
//  listadelocais.swift
//  ExerciciodeMapa
//
//  Created by Ngori Januario on 21/02/23.
//

import SwiftUI

struct listadelocais: View {
    
    @EnvironmentObject private var vm: localizacaoViewModel
    
    var body: some View {
        List{
            ForEach(vm.locations){ localizacao in
                Button{
                    vm.abripriximoLocal(localizacao: localizacao)
                }label: {
                    listadelocaisrepetidas(localizacao: localizacao)
                }
                
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct listadelocais_Previews: PreviewProvider {
    static var previews: some View {
        listadelocais()
            .environmentObject(localizacaoViewModel())
    }
}

extension listadelocais{
    
    private func listadelocaisrepetidas(localizacao: localizacao) -> some View {
        HStack{
            if let imageName = localizacao.imageNames.first{
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45,height: 45)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading){
                Text(localizacao.name)
                    .font(.headline)
                Text(localizacao.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment:.leading)
        }
    }
}
