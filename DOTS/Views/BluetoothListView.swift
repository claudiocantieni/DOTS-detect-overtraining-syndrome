//
//  BluetoothListView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 06.10.22.
//

import SwiftUI
import CoreBluetooth

struct BluetoothListView: View {

    
    @AppStorage("PUUID") var selected = ""
    @AppStorage("connected") var connected: Bool = false
    
    @ObservedObject var HRVModel = HRV()
    @ObservedObject var BleModel = BLEModel()
    var body: some View {
        List {
            // list shows all available peripherals
            ForEach(BleModel.peripherals, id: \.self) { peripheral in
                HStack {
                    Text(peripheral.name ?? "unnamed device")
                        .font(.custom("Ubuntu-Medium", size: 18))
                        .padding(.horizontal)
                    Spacer()

                    Button {
    // connect to peripheral and remember it for next time
                        UserDefaults.standard.set(peripheral.identifier.uuidString, forKey: "PUUID")
                            UserDefaults.standard.synchronize()
                        HRVModel.connect()
                        
                    } label: {
                    
                        if peripheral.identifier.uuidString == selected && connected == true {
                            Text("Connected")
                                .foregroundColor(.accentColor)
                                .font(.custom("Ubuntu-Regular", size: 18))
                                .padding(.horizontal)
                        }
                        else {
                            Text("Not connected")
                                .foregroundColor(.accentColor)
                                .font(.custom("Ubuntu-Regular", size: 18))
                                .padding(.horizontal)
                                
                        }
                    }
                    
                
                }
               

            }
// delete peripheral
            .onDelete { _ in
                UserDefaults.standard.removeObject(forKey: "PUUID")
                HRVModel.stopMeasure2()
                UserDefaults.standard.set(false, forKey: "connected")
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .navigationTitle("Devices")
        
    
        
    }
}

