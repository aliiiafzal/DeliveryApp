//
//  ScannerViewController.swift
//  DeliveryApp
//
//  Created by Ali Afzal on 10/05/2023.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController {
  
  //MARK: - PROPERTIES
  var captureSession: AVCaptureSession!
  var previewLayer: AVCaptureVideoPreviewLayer!
  
  //MARK: - OUTLETS
  @IBOutlet weak var cameraView: UIView!
  @IBOutlet weak var qrCodeResult: UILabel!
  @IBOutlet weak var torchButton: UIButton!
  @IBOutlet weak var navView: UIView!
  
  //MARK: - LIFECYCLE
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if (captureSession?.isRunning == false) {
      captureSession.startRunning()
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    if (captureSession?.isRunning == true) {
      captureSession.stopRunning()
    }
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }
  
  //MARK: - ACTIONS
  @IBAction func torchButtonPressed(_ sender: UIButton) {
    toggleFlash()
  }
  
  @IBAction func backButtonPressed(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  //MARK: - HELPERS
  func toggleFlash() {
    let device = AVCaptureDevice.default(for: AVMediaType.video)
    if ((device?.hasTorch) != nil) {
      try? device?.lockForConfiguration()
      let torchOn = !device!.isTorchActive
      device?.torchMode = torchOn ? AVCaptureDevice.TorchMode.on : AVCaptureDevice.TorchMode.off
      let torchOnImage = UIImage(named: "light-bulb")
      let torchOffImage = UIImage(named: "turned-off")
      let imageToUse = torchOn ? torchOffImage : torchOnImage
      torchButton.setBackgroundImage(imageToUse, for: .normal)
      device?.unlockForConfiguration()
    }
  }
  
  func configureUI() {
    cameraView.backgroundColor = UIColor.black
    captureSession = AVCaptureSession()
    
    guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
    let videoInput: AVCaptureDeviceInput
    
    do {
      videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
    } catch {
      return
    }
    
    if (captureSession.canAddInput(videoInput)) {
      captureSession.addInput(videoInput)
    } else {
      failed()
      return
    }
    
    let metadataOutput = AVCaptureMetadataOutput()
    
    if (captureSession.canAddOutput(metadataOutput)) {
      captureSession.addOutput(metadataOutput)
      
      metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      metadataOutput.metadataObjectTypes = [.qr]
    } else {
      failed()
      return
    }
    
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.frame = cameraView.layer.bounds
    previewLayer.videoGravity = .resizeAspectFill
    cameraView.layer.addSublayer(previewLayer)
    
    captureSession.startRunning()
    
    let shadowPath = UIBezierPath(rect: navView.bounds)
    navView.layer.masksToBounds = false
    navView.layer.shadowColor = UIColor.black.cgColor
    navView.layer.shadowOffset = CGSizeMake(0.0, 5.0)
    navView.layer.shadowOpacity = 0.3
    navView.layer.shadowPath = shadowPath.cgPath
  }
  
  func failed() {
    let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
    captureSession = nil
  }
  
  func found(code: String) {
    print("QR Code Result is :", code)
    qrCodeResult.text = code
  }
}

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
  
  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    captureSession.stopRunning()
    
    if let metadataObject = metadataObjects.first {
      guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
      guard let stringValue = readableObject.stringValue else { return }
      AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
      found(code: stringValue)
    }
    
    dismiss(animated: true)
  }
}
