//
//  HRV.swift
//  DOTS
//
//  Created by Claudio Cantieni on 13.09.22.
//

import Foundation
class HRV: ObservableObject {
    
    let managedObjectContext = PersistenceController.shared.container.viewContext
    var hrv: Double = 0
    
    var heartRateRRIntervalDatas = [Double]()
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
    
    func heartRateRRDidArrive(_ rr: Double) {
        print("<rr=\(rr)>")
        heartRateRRIntervalDatas.append(rr);

        duration += (rr / 1000.0);

        heartRateRRCount += 1;
       
        
        
    }
    
    func startMeasure() {
        heartRateRRIntervalDatas = [Double]()
        heartRateRRCount = 0;
        duration = 0.0
    }

    func addData() {
        //TODO: adapt to textfields
        if heartRateRRIntervalDatas.count > 0 {
            let hearts = Hearts(context: managedObjectContext)
            hearts.timestamp = Date()
      
            hearts.hrv = Double(hrv) as NSNumber?
            
            
           
           
            
            do {
                try managedObjectContext.save()

            }
            catch {
                
            }
        }
        
        
    }
}
