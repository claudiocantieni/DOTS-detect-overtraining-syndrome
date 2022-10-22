//
//  BLEModel.swift
//  DOTS
//
//  Created by Claudio Cantieni on 04.09.22.
//

import Foundation
import CoreBluetooth
import UIKit

// Services and characteristics to look for
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
    
    @Published var peripherals: [CBPeripheral] = []
    @Published var bpm: Int?
    // search for peripherals and find them
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
        if peripherals.contains(peripheral) {
            
        }
        else {
            // append peripheral to list to show in BluetoothListView
            self.peripherals.append(peripheral)
        }

        
        

        

    }


    
    

}


