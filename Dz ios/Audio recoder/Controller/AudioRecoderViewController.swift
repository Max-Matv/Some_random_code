//
//  AudioRecoderViewController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 01.Jul.22.
//

import UIKit
import AVFoundation

class AudioRecoderViewController: UIViewController {
    
    private var audioSession: AVAudioSession?
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    private var numberOfRecords: Int = 0

    @IBOutlet weak private var buttonLabel: UIButton!
    @IBOutlet weak private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        audioSession = AVAudioSession.sharedInstance()
        if let number: Int = UserDefaults.standard.object(forKey: "lastNumberOfRecord") as? Int {
            numberOfRecords = number
        }
        AVAudioSession.sharedInstance().requestRecordPermission { permission in
            if permission {
                print("access")
            }
        }
    }
    
    @IBAction func record(_ sender: Any) {
        if audioRecorder == nil {
            numberOfRecords += 1
            let fileName = getDirectoryOfRecording().appendingPathComponent("\(numberOfRecords).m4a")
            
            let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
            do {
                audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
                audioRecorder?.delegate = self
                audioRecorder?.record()
                
                buttonLabel.setImage(UIImage(systemName: "mic.slash.circle.fill"), for: .normal)
            } catch {
                displayAlerts(title: "Error", message: "Recording failed")
            }
        } else {
            audioRecorder?.stop()
            UserDefaults.standard.set(numberOfRecords, forKey: "lastNumberOfRecord")
            tableView.reloadData()
            audioRecorder = nil
            
            buttonLabel.setImage(UIImage(systemName: "mic.circle.fill"), for: .normal)
        }
    }
    
    private func getDirectoryOfRecording() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = path[0]
        return documentDirectory
    }
    
    private func displayAlerts(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "dissmis", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}

extension AudioRecoderViewController: AVAudioRecorderDelegate {
    
}

extension AudioRecoderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRecords
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AudioRecordingCell", for: indexPath) as? AudioRecordingCell else {
            fatalError()
        }
        cell.setupCell(name: "Record \(indexPath.row + 1)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let path = getDirectoryOfRecording().appendingPathComponent("\(indexPath.row + 1).m4a")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: path)
            audioPlayer?.play()
        } catch {
            
        }
    }
    
}
