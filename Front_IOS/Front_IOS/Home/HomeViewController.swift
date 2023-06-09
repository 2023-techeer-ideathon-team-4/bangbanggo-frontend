import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var initLocationImage: UIImageView!
    
    let numbers = Array(1...40)
    let locationManager = CLLocationManager()
    var circleOverlay: MKOverlay?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 위치 관리자 설정
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
        settingButton()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(initLocationImageTapped))
        initLocationImage.addGestureRecognizer(tapGesture)
        initLocationImage.isUserInteractionEnabled = true
    }
    
    @objc func initLocationImageTapped() {
        // 위치 업데이트 재시작
        locationManager.startUpdatingLocation()
    }
    
    func settingButton() {
        // 버튼의 둥근 모서리와 테두리 스타일 설정
        searchButton.layer.cornerRadius = 6 // 반지름 값으로 버튼 크기의 절반 설정하여 둥글게 만듦
        searchButton.layer.borderWidth = 1.0 // 테두리 두께 설정
        searchButton.layer.borderColor = UIColor.gray.cgColor // 테두리 색상 설정
        searchButton.clipsToBounds = true // 둥근 모서리를 적용하기 위해 필요한 설정

        // 버튼의 배경색 설정 (옵션)
        searchButton.backgroundColor = UIColor.white // 원하는 배경색으로 설정
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        
        // 맵 뷰의 중심을 현재 위치로 설정
        mapView.setCenter(currentLocation.coordinate, animated: true)
        
        // 현재 위치에 핀 추가
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentLocation.coordinate
        annotation.title = "나의 위치"
        mapView.addAnnotation(annotation)
        
        // 위치 업데이트 중지
        locationManager.stopUpdatingLocation()
        
        // 지도 확대
        let region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
    }

    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 하나의 컴포넌트만 사용
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numbers.count // 숫자 배열의 길이 반환
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(numbers[row]) // 각 행에 해당하는 숫자를 문자열로 반환
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedNumber = numbers[row] // 선택된 행에 해당하는 숫자
        print(selectedNumber)
        
        // 이전에 그려진 원 삭제
        if let overlay = circleOverlay {
            mapView.removeOverlay(overlay)
        }
        
        // 선택된 숫자에 맞는 반경을 계산
        let radiusInMeters = CLLocationDistance(selectedNumber * 1000)
        
        // 현재 위치를 중심으로 원을 그림
        let circle = MKCircle(center: mapView.centerCoordinate, radius: radiusInMeters)
        mapView.addOverlay(circle)
        circleOverlay = circle
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.fillColor = UIColor.blue.withAlphaComponent(0.2)
            circleRenderer.strokeColor = UIColor.blue
            circleRenderer.lineWidth = 1
            return circleRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}
