//
//  BluetoothListView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 06.10.22.
//

import SwiftUI
import CoreBluetooth

struct BluetoothListView: View {

    var selected = [Selected]()

    @ObservedObject var HRVModel = HRV()
    @ObservedObject var BleModel = BLEModel()
    var body: some View {
        VStack {

            List(BleModel.peripherals, id: \.self) { peripheral in
                ZStack {
                    Text(peripheral.name ?? "unnamed device")
                Button {
                    let selected = Selected(id: [peripheral.identifier], name: peripheral.name ?? "unnamed device")
                    do {
                        

                        // Create JSON Encoder
                        let encoder = JSONEncoder()

                        // Encode Note
                        let data = try encoder.encode(selected)

                        // Write/Set Data
                        UserDefaults.standard.set(data, forKey: "selectedPeripheral")
                        UserDefaults.standard.synchronize()
                    } catch {
                        print("Unable to Encode Note (\(error))")
                    }
                    
                } label: {
                    
                }
                .buttonStyle(.bordered)
                }
               

            }
            
            
            
        
        }
    
        
    }
}

