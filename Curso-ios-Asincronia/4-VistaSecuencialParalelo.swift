//
//  VistaSecuencialParalelo.swift
//  Curso-ios-Asincronia
//
//  Created by Equipo 8 on 10/2/26.
//

import SwiftUI

struct VistaSecuencialParalelo: View {
    @State private var log = ""
    @State private var tiempoTotal = 0.0
    
    var body: some View {
        VStack(spacing: 10) {
            ScrollView { // Usar ScrollView por si el log crece mucho
                Text(log)
                    .font(.system(.body, design: .monospaced))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            .frame(height: 300)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            
            HStack(spacing: 20) {
                Button("Desayuno secuencial") {
                    Task {
                        await prepararDesayunoSecuencial()
                    }
                }
                .buttonStyle(.bordered)
                
                Button("Desayuno paralelo") {
                    Task {
                        await prepararDesayunoParalelo()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
    
    // --- Funciones de apoyo (Fuera del body) ---
    
    func hacerCafe() async -> String {
        log += "Preparando café ☕️ \n"
        try? await Task.sleep(for: .seconds(2))
        return "Café listo ☕️"
    }
    
    func tostarPan() async -> String {
        log += "Preparando tostada 🍞\n"
        try? await Task.sleep(for: .seconds(3))
        return "Tostada lista 🍞"
    }
    
    func prepararDesayunoSecuencial() async {
        log = "⏳ Iniciando modo secuencial...\n"
        let inicio = Date()
        
        let cafe = await hacerCafe()
        log += cafe + "\n"
        
        let pan = await tostarPan()
        log += pan + "\n"
        
        let fin = Date()
        let total = fin.timeIntervalSince(inicio).formatted()
        log += "✅ Terminado en \(total) segundos."
    }
    
    func prepararDesayunoParalelo() async {
        log = "⚡️ Iniciando modo paralelo...\n"
        let inicio = Date()
        
        // Usamos async let para que ambas tareas comiencen al mismo tiempo
        async let cafeTask = hacerCafe()
        async let panTask = tostarPan()
        
        // Esperamos el resultado de ambas
        let (resultadoCafe, resultadoPan) = await (cafeTask, panTask)
        
        log += resultadoCafe + "\n"
        log += resultadoPan + "\n"
        
        let fin = Date()
        let total = fin.timeIntervalSince(inicio).formatted()
        log += "✅ Terminado en \(total) segundos."
    }
}

#Preview {
    VistaSecuencialParalelo()
}
