//
//  BLEModel.swift
//  DOTS
//
//  Created by Claudio Cantieni on 04.09.22.
//

import Foundation
import CoreBluetooth
import UIKit


let heartRateServiceCBUUID = CBUUID(string: "0x180D")
let heartRateMeasurementCharacteristicCBUUID = CBUUID(string: "2A37")
let bodySensorLocationCharacteristicCBUUID = CBUUID(string: "2A38")



class BLEModel: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
        
        
        
    }
    
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    
    @Published var selectedPeripheral: [UUID] = []

    @Published var peripherals: [CBPeripheral] = []
    @Published var bpm: Int?
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch (central.state) {
        case .unknown:
            print("state: unknown")
            break;
        case .resetting:
            print("state: resetting")
            break;
        case .unsupported:
            print("state: unsupported")
            break;
        case .unauthorized:
            print("state: unauthorized")
            break;
        case .poweredOff:
            print("state: power off")
            break;
        case .poweredOn:
            print("state: power on")
            let HEART_RATE_SERVICE: String = "180D"
            let services = [CBUUID(string: HEART_RATE_SERVICE)]
            let options: Dictionary = [CBCentralManagerScanOptionAllowDuplicatesKey: false];
            self.centralManager.scanForPeripherals(withServices: services, options: options)
            break;
        @unknown default:
            print("Error")
        }
    }

    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String:Any],
                        rssi RSSI: NSNumber) {

        print("peripheral: \(peripheral) rssi=\(RSSI) data=\(advertisementData)")

        // we need to store reference to peripheral
        self.peripherals.append(peripheral)
        

        
//        self.centralManager.stopScan()
    }
//    func connectToPeripheral() {
//
//        self.peripheral = selectedPeripheral as? CBPeripheral
//    }
    func decodeSelected() {
        if let data = UserDefaults.standard.data(forKey: "selectedPeripheral") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let selected = try decoder.decode(Selected.self, from: data)
                selectedPeripheral = selected.id
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
    }
    
    

}


