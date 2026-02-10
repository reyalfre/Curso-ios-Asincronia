//
//  VistaTaskAIEntrar.swift
//  Curso-ios-Asincronia
//
//  Created by Equipo 8 on 10/2/26.
//

import SwiftUI

struct VistaTaskAIEntrar: View {
    @State private var nombre = "Cargando..."
    @State private var biografia = ""
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.blue)
            Text(nombre)
                .font(.title)
                .bold()
            Text(biografia)
                .foregroundStyle(.secondary)
        }
        //Se ejecuta el task cuando la vista va a aparecer
        //task nos cancela la ejecucion automáticamente si salimos de la vista
        
        //Importante: No usamos el onAppear para llamar a métodos asíncronos, ya que no cancela la llamada asíncrona en caso de que salgamos de la vista.
        .task {
            await cargarPerfil()
        }
    }
    func cargarPerfil() async {
        //Simulamos la espera
        try? await Task.sleep(for: .seconds(2))

        nombre = "Pepito Pérez"
        biografia = "Estudiante de ios y adicto al café."
    }
}

#Preview {
    VistaTaskAIEntrar()
}
