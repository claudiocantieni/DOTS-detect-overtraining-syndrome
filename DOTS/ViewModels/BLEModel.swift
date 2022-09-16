//
//  BLEModel.swift
//  DOTS
//
//  Created by Claudio Cantieni on 04.09.22.
//
/*
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
    var heartRatePeripheral: CBPeripheral!

    @Published var bpm: Int?
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        
        switch central.state {
            case .unknown:
              print("central.state is .unknown")
            case .resetting:
              print("central.state is .resetting")
            case .unsupported:
              print("central.state is .unsupported")
            case .unauthorized:
              print("central.state is .unauthorized")
            case .poweredOff:
              print("central.state is .poweredOff")
            case .poweredOn:
              print("central.state is .poweredOn")
            centralManager.scanForPeripherals(withServices: [heartRateServiceCBUUID])
              @unknown default:
                print("Error")
                  }
        
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }

        for service in services {
            print(service)
            peripheral.discoverCharacteristics(nil, for: service)


        }

    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }

         for characteristic in characteristics {
           print(characteristic)
             
             if characteristic.properties.contains(.read) {
               print("\(characteristic.uuid): properties contains .read")
                 peripheral.readValue(for: characteristic)

             }
             if characteristic.properties.contains(.notify) {
               print("\(characteristic.uuid): properties contains .notify")
                 peripheral.setNotifyValue(true, for: characteristic)

             }

         }
    }
    
    private func heartRate(from characteristic: CBCharacteristic) -> Int {
      guard let characteristicData = characteristic.value else { return -1 }
      let byteArray = [UInt8](characteristicData)

      let firstBitValue = byteArray[0] & 0x01
      if firstBitValue == 0 {
        // Heart Rate Value Format is in the 2nd byte
        return Int(byteArray[1])
      } else {
        // Heart Rate Value Format is in the 2nd and 3rd bytes
        return (Int(byteArray[1]) << 8) + Int(byteArray[2])
      }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic,
                    error: Error?) {
      switch characteristic.uuid {
        case bodySensorLocationCharacteristicCBUUID:
          print(characteristic.value ?? "no value")
      case heartRateMeasurementCharacteristicCBUUID:
          bpm = heartRate(from: characteristic)


        default:
          print("Unhandled Characteristic UUID: \(characteristic.uuid)")

      }
    }


    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
        heartRatePeripheral = peripheral
        centralManager.stopScan()
        centralManager.connect(heartRatePeripheral)
        heartRatePeripheral.delegate = self

    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
      print("Connected!")
        heartRatePeripheral.discoverServices([heartRateServiceCBUUID])

    }
}
*/

