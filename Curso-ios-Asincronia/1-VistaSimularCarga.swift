//
//  ContentView.swift
//  Curso-ios-Asincronia
//
//  Created by Equipo 8 on 10/2/26.
//

import SwiftUI

struct VistaSimularCarga: View {
    @State private var mensaje = "Presione el botón"
    @State private var cargando = false
    var body: some View {
        VStack(spacing: 20) {
            if cargando {
                ProgressView()
                    .controlSize(.large)
            }
            Text(mensaje)
                .font(.title2)

            Button("Simular descarga") {

                Task {
                    await procesarDescarga()
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(cargando)
            
            //Este botón es el que no se debe utilizar
            Button("Simular descarga bloqueante") {
                cargando = true
                mensaje = "Conectando al servidor..."
                Thread.sleep(forTimeInterval: 2)
                cargando = false
                mensaje = "¡Datos cargados!"
            }
            .buttonStyle(.borderedProminent)
        }

    }
    func procesarDescarga() async {
        cargando = true
        mensaje = "Conectando al servidor..."

        //Simular la carga
        try? await Task.sleep(for: .seconds(3))

        mensaje = "¡Datos recibidos! 📦"
        cargando = false

    }
}

#Preview {
    VistaSimularCarga()
}
