//
//  ViewModel.swift
//  TimerAppInMVVM
//
//  Created by Kunal Arora on 21/12/15.
//  Copyright © 2015 Kunal Arora. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class ViewModel:NSObject {
    let startTaps = PublishSubject<Void>()
    let pauseTaps = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    
    var elapsedTime: NSTimeInterval = 0.0
    var startTime = NSDate.timeIntervalSinceReferenceDate()
    var time: NSTimeInterval = 0.0
    var time2: NSTimeInterval = 0.0
    var timerText = PublishSubject<String>()
    
    //    var counterStart = 0
    //    var counterPause = 0
    
//    var start = PublishSubject<Void>()
//    var stop = PublishSubject<Void>()
//    var reset = PublishSubject<Void>()
//    var pause = PublishSubject<Void>()
//    var resume = PublishSubject<Void>()
    
    var one = PublishSubject<String>()
    var two = PublishSubject<String>()
    var three = PublishSubject<Bool>()
    var timer = NSTimer()
    
    func updateTime() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        
        elapsedTime = currentTime - startTime + time
        time2 = elapsedTime
        
        //calculate the minutes in elapsed time.
        
        let minutes = UInt8(elapsedTime / 60.0)
        
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        let text = "\(strMinutes):\(strSeconds):\(strFraction)"
        self.timerText.onNext(text)
        
    }
    
    override init() {
        super.init()
        one.on(.Next("Start"))
        two.on(.Next("Pause"))
        startTaps.subscribeNext(startButtonTapped).addDisposableTo(disposeBag)
        pauseTaps.subscribeNext(pauseButtonTapped).addDisposableTo(disposeBag)
//        one = just("Kunal")
//        one = just("k")
    }
    
    func startButtonTapped(){
        
        if SharedConstants.counterStart == 0{
            let aSelector : Selector = "updateTime"
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            self.startTime = NSDate.timeIntervalSinceReferenceDate()
            SharedConstants.counterStart = 1
//            self.start.onNext()
            one.on(.Next("Stop"))
            three.on(.Next(true))
//            one = just("Stop")
           
//            one.subscribe{event in print(event)}
        }
        else if SharedConstants.counterStart == 1 {
            timer.invalidate()
            SharedConstants.counterStart = 2
            SharedConstants.counterPause = 0
//            self.stop.onNext()
            one.on(.Next("Reset"))
            two.on(.Next("Pause"))
            three.on(.Next(false))
        }
        else if SharedConstants.counterStart == 2 {
            self.timerText.onNext("00:00:00")
            self.time = 0
            SharedConstants.counterStart = 0
//            self.reset.onNext()
            one.on(.Next("Start"))
        }
    }
    
    
    func pauseButtonTapped() {
        if SharedConstants.counterPause == 0 {
            timer.invalidate()
            time = time2
            SharedConstants.counterPause = 1
            two.on(.Next("Resume"))
//            self.pause.onNext()
        }
        else if SharedConstants.counterPause == 1 {
            let aSelector : Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
            SharedConstants.counterPause = 0
            two.on(.Next("Pause"))
//            self.resume.onNext()
        }
    }
    
}