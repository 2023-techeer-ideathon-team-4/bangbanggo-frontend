import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController,CLLocationManagerDelegate {

        @IBOutlet weak var mapView: MKMapView!
        
        let locationManager = CLLocationManager()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // 위치 관리자 설정
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
            mapView.showsUserLocation = true
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
        }
    }
