//
//  VistaMainActor.swift
//  Curso-ios-Asincronia
//
//  Created by Equipo 8 on 10/2/26.
//

import SwiftUI

@Observable
class UsuarioViewModel {
    var nombreUsuario = "Cargando..."

    func actualizarNombreUsuario() async {
    }
}
struct VistaMainActor: View {
    @State private var viewModel = UsuarioViewModel()
    var body: some View {
        Text(viewModel.nombreUsuario)
            .task {
                await viewModel.actualizarNombreUsuario()
            }
    }
}

#Preview {
    VistaMainActor()
}
