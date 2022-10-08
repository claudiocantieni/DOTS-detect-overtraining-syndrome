//
//  HRV.swift
//  DOTS
//
//  Created by Claudio Cantieni on 13.09.22.
//

import Foundation
class HRV: ObservableObject, HeartRateDelegate {
    
    let managedObjectContext = PersistenceController.shared.container.viewContext
    var hrv: Double = 0
    var hr: Double = 0
    @Published var bpm: Int?
    
    var heartRateCenter: HeartRateCenter!
    var heartRateRRIntervalDatas = [Double]()
    var heartRateHRIntervalDatas = [Double]()
    var duration = 0.0
    var heartRateRRCount = 0
    func analyzeIntervals() {
        
        

        let beatsData = BeatsData(intervals: heartRateRRIntervalDatas)
        beatsData.removeIrregularBeats()

        if !beatsData.isValid {
            return
        }

        hrv = beatsData.rmssd
       
        

        let concurrentQueue = DispatchQueue(label: "spectrum-analysis", attributes: .concurrent)
        concurrentQueue.async {
            // Resample intervals with Const.RESMPLE_INTERAL_MS millisec interval.
            let resampledIntervals = SampleInterpolator.process(beatsData.beats)
            if resampledIntervals == nil {
                return
            }

            // AR spectrum analysis
            let spectrumData = SpectrumAnalyzer.process(resampledIntervals!)
            if (spectrumData != nil) {
                DispatchQueue.main.async {
                   

                    let lf = spectrumData!.lf
                    let hf = spectrumData!.hf
                    let lfhf = lf / hf
                    
                }
            }

            // BalanceIndex analysis
            let logSpectrumData = BalanceIndexAnalyzer.process(resampledIntervals: resampledIntervals!)
            let (a, _ ) = logSpectrumData.calcSlope()
            let balanceIndex = -a

            DispatchQueue.main.async {
                
            }

        }
    }
    func heartRateDeviceDidConnect() {
        print("<connect>")
        
    }

    func heartRateDeviceDidDisconnect() {
        print("<disconnect>")
        
    }
    func heartRateRRDidArrive(_ rr: Double) {
        print("<rr=\(rr)>")
        heartRateRRIntervalDatas.append(rr);
        

        duration += (rr / 1000.0);

        heartRateRRCount += 1;
       
        
        
    }
    func heartRateHRDidArrive(_ hr: Double) {
        
        heartRateHRIntervalDatas.append(hr)
        bpm = Int(hr)
        
    }
    
    func getMinHR() {
        hr = heartRateHRIntervalDatas.min() ?? 0
        
    }

    
    func startMeasure() {
        
        
        
        // show breath view
        heartRateCenter = HeartRateCenter(delegate: self)
        heartRateCenter.setup()
        
        
        heartRateRRIntervalDatas = [];
        heartRateHRIntervalDatas = [];
        heartRateRRIntervalDatas = [Double]()
        heartRateRRCount = 0;
        duration = 0.0
        
        
        
        
    }
    func stopMeasure() {
        if heartRateCenter != nil {
            heartRateCenter.cleanup()
            heartRateCenter = nil
            

            

            analyzeIntervals()
            getMinHR()
        }

            
            
        }
    
    
    func stopMeasure2() {
        
        heartRateCenter = nil
    }
    func connect() {
        heartRateCenter = HeartRateCenter(delegate: self)
        heartRateCenter.setup()
    }

    func addData() {
        //TODO: adapt to textfields
        if heartRateRRIntervalDatas.count > 0 {
            let hearts = Hearts(context: managedObjectContext)
            hearts.timestamp = NSCalendar.current.startOfDay(for: Date())
            
            hearts.rhr = Double(hr) as NSNumber?
            
            
            
           
           
            
            do {
                try managedObjectContext.save()

            }
            catch {
                
            }
            let hearts2 = Hearts(context: managedObjectContext)
            hearts2.timestamp =  NSCalendar.current.date(byAdding: .second, value: 1, to: NSCalendar.current.startOfDay(for: Date()))!
            
            
            hearts2.hrv = Double(hrv) as NSNumber?
            
            
           
           
            
            do {
                try managedObjectContext.save()

            }
            catch {
                
            }
            
        }
        
        
    }
}
