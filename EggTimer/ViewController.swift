import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var timerDone: UILabel!
    let eggTimes = ["Soft" : 240, "Medium" : 360, "Hard" : 720]
    var timer = Timer()
    var totalTime = 0
    var passedTime = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle
        
        progressBar.progress = 0.0
        passedTime = 0
        timerDone.text = hardness

     

        if hardness != nil {
            totalTime = eggTimes[hardness!]!
        }else {
            print(Error.self)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)

    }
    
    @objc func updateCounter() {
        if passedTime < totalTime {
            passedTime += 1
            progressBar.progress = Float(passedTime) / Float(totalTime)
            print(progressBar.progress)
        }else {
            timerDone.text = "Done!"
            playSound(currentTitle: "alarm_sound")
            timer.invalidate()
        }
    }
    
    func playSound(currentTitle: String) {
        let url = Bundle.main.url(forResource: currentTitle, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }

}
