//
//  ViewController.swift
//  objection
//
//  Created by KENK on 2024/3/16.
//
import UIKit
import AVFoundation
import CoreMotion

class ViewController: UIViewController {
    var player: AVAudioPlayer?
    let motionManager = CMMotionManager()
  
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initMp3Player   //这里forResource里面填写文件名
        guard let url = Bundle.main.url(forResource: "objectionJapan", withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
        } catch {
            print("Error loading audio file: \(error.localizedDescription)")
        }
        
        // setAccInterval
        motionManager.accelerometerUpdateInterval = 0.2
        
        // 开始加速度计更新
        motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
            if let acceleration = data?.acceleration {
                // 计算加速度大小
                let accelerationMagnitude = sqrt(pow(acceleration.x, 2) + pow(acceleration.y, 2) + pow(acceleration.z, 2))
                
                // 根据加速度大小判断是否触发抖动
                if accelerationMagnitude > 1.0 { // 这个阈值可以根据需要调整
                    self?.playAudio()
                }
            }
        }
    }
    
    // play
    func playAudio() {
        player?.play()
    }
}
